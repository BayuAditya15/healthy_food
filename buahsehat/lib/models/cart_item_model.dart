class CartItemModel {
  CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.description,
    required this.category,
  });

  final int productId;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final String description;
  final String category;

  double get totalPrice => price * quantity;

  CartItemModel copyWith({
    int? productId,
    String? name,
    double? price,
    int? quantity,
    String? image,
    String? description,
    String? category,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'description': description,
      'category': category,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
    );
  }
}
