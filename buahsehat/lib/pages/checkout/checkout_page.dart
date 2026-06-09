import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Pastikan path import ini sesuai dengan struktur folder project Anda
import '../../services/cart_service.dart';
import '../cart/cart_page.dart';
import 'review_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk menangkap input user
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _paymentDetailsController = TextEditingController();

  String? selectedCountry = "Indonesia";
  bool _isSubmitting = false;
  String _paymentMethod = 'Cash on Delivery';

  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  @override
  void initState() {
    super.initState();
    _prefillFromCachedProfile();
  }

  Future<void> _prefillFromCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
    });
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final items = CartService.items.value
        .map(
          (e) => {
            'product_id': e.productId,
            'name': e.name,
            'price': e.price,
            'quantity': e.quantity,
          },
        )
        .toList();

    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Keranjang kosong')));
      return;
    }

    setState(() => _isSubmitting = true);

    final payload = {
      'items': items,
      'shipping_name': _nameController.text,
      'shipping_email': _emailController.text,
      'shipping_phone': _phoneController.text,
      'shipping_zip': _zipController.text,
      'shipping_city': _cityController.text,
      'shipping_country': selectedCountry,
      'payment_method': _paymentMethod,
      'payment_details': _paymentDetailsController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/orders'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        await CartService.clear();
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ReviewPage(purchasedItems: items)),
        );
      } else {
        final error =
            jsonDecode(response.body)['message'] ?? 'Gagal memproses order';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // 🔙 HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                const SizedBox(height: 25),

                // 🔥 FORM
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        input("Full Name", "Ujang Kosim", _nameController),
                        input(
                          "Email Address",
                          "info@example.com",
                          _emailController,
                        ),
                        input(
                          "Phone",
                          "Enter your phone number",
                          _phoneController,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: input(
                                "Zip Code",
                                "Enter here",
                                _zipController,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: input(
                                "City",
                                "Enter here",
                                _cityController,
                              ),
                            ),
                          ],
                        ),
                        _buildDropdown(),
                        _buildPaymentDropdown(),
                        input(
                          "Payment Details",
                          "Optional",
                          _paymentDetailsController,
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔥 BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _isSubmitting ? null : _submitOrder,
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "PLACE ORDER",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper Input
  Widget input(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            validator: (val) => val!.isEmpty ? 'Field ini wajib diisi' : null,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Country"),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selectedCountry,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              "Indonesia",
              "Malaysia",
              "Singapore",
              "Japan",
              "USA",
              "Germany",
            ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => selectedCountry = v),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Payment Method"),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _paymentMethod,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              'Cash on Delivery',
              'Bank Transfer',
              'Manual Card',
            ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
        ],
      ),
    );
  }
}
