class WishlistItemModel {
  WishlistItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  final int productId;
  final String name;
  final double price;
  final String image;
  final String description;
  final String category;

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
    };
  }

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
    );
  }
}
