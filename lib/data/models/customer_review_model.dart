class CustomerReviewModel {
  CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json['name'] ?? '',
        review: json['review'] ?? '',
        date: json['date'] ?? '',
      );

  final String name;
  final String review;
  final String date;

  Map<String, dynamic> toJson() => {
        'name': name,
        'review': review,
        'date': date,
      };
}
