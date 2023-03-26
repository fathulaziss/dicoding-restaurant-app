import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';

class RestaurantSearchResultModel {
  RestaurantSearchResultModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResultModel.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResultModel(
        error: json['error'] ?? false,
        founded: json['founded'] ?? 0,
        restaurants: json['restaurants'] != null
            ? List<RestaurantModel>.from(
                (json['restaurants'] as List)
                    .map((x) => RestaurantModel.fromJson(x)),
              )
            : [],
      );

  final bool error;
  final int founded;
  final List<RestaurantModel> restaurants;
}
