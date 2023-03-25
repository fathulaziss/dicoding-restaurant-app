import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';

class RestaurantDetailResultModel {
  RestaurantDetailResultModel({
    required this.error,
    required this.message,
    this.restaurant,
  });

  factory RestaurantDetailResultModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResultModel(
        error: json['error'] ?? false,
        message: json['message'] ?? '',
        restaurant: json['restaurant'] != null
            ? RestaurantModel.fromJson(json['restaurant'])
            : null,
      );

  final bool error;
  final String message;
  final RestaurantModel? restaurant;
}
