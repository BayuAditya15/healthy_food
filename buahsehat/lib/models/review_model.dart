class ReviewModel {
  final int id;
  final String userName;
  final String comment;
  final double rating;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userName: json['user']['name'] ?? 'User',
      comment: json['comment'] ?? '',
      rating: double.parse(json['rating'].toString()),
    );
  }
}
