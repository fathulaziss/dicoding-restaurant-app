import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';

class RestaurantResultModel {
  RestaurantResultModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResultModel.fromJson(Map<String, dynamic> json) =>
      RestaurantResultModel(
        error: json['error'] ?? false,
        message: json['message'] ?? '',
        count: json['count'] ?? 0,
        restaurants: json['restaurants'] != null
            ? List<RestaurantModel>.from(
                (json['restaurants'] as List)
                    .map((x) => RestaurantModel.fromJson(x)),
              )
            : [],
      );

  final bool error;
  final String message;
  final int count;
  final List<RestaurantModel> restaurants;

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'count': count,
        'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
