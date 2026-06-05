import 'package:flutter/material.dart';
import '../payment/payment_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool saveAddress = false;

  final List<String> countries = [
    "Indonesia",
    "Malaysia",
    "Singapore",
    "Japan",
    "USA",
    "Germany",
  ];

  String? selectedCountry = "USA";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ================= HEADER =================
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Checkout",
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),

              const SizedBox(height: 25),

              // ================= STEP INDICATOR =================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      circle(true, colorScheme),
                      const SizedBox(width: 8),
                      Expanded(child: line(true, colorScheme)),
                      const SizedBox(width: 8),
                      circle(false, colorScheme),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Shipping Address",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Payment Method",
                        style: textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ================= FORM =================
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      input(context, "Full Name", "Ujang Kosim"),
                      input(context, "Email Address", "info@example.com"),
                      input(context, "Phone", "Enter your phone number"),

                      Row(
                        children: [
                          Expanded(child: input(context, "Zip Code", "Enter here")),
                          const SizedBox(width: 12),
                          Expanded(child: input(context, "City", "Enter here")),
                        ],
                      ),

                      // ================= DROPDOWN =================
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Country",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onBackground,
                                )),
                            const SizedBox(height: 6),

                            DropdownButtonFormField<String>(
                              value: countries.contains(selectedCountry)
                                  ? selectedCountry
                                  : null,

                              dropdownColor: theme.cardColor,

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.cardColor,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                              ),

                              items: countries.map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(
                                    country,
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                );
                              }).toList(),

                              onChanged: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            value: saveAddress,
                            activeColor: colorScheme.primary,
                            onChanged: (val) {
                              setState(() {
                                saveAddress = val!;
                              });
                            },
                          ),
                          Text(
                            "Save shipping address",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentPage()),
                    );
                  },
                  child: const Text("NEXT", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INPUT =================
  Widget input(BuildContext context, String label, String hint) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(color: colorScheme.onBackground)),
          const SizedBox(height: 6),
          TextField(
            style: TextStyle(color: colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: theme.hintColor),
              filled: true,
              fillColor: theme.cardColor,
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

  // ================= STEP CIRCLE =================
  Widget circle(bool active, ColorScheme colorScheme) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: active
              ? colorScheme.primary
              : colorScheme.outline,
          width: 2,
        ),
      ),
      child: active
          ? Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }

  // ================= STEP LINE =================
  Widget line(bool active, ColorScheme colorScheme) {
    return Container(
      height: 2,
      color: active
          ? colorScheme.primary
          : colorScheme.outline,
    );
  }
}