import 'dart:convert';

import 'package:dicoding_restaurant_app/models/drink_model.dart';
import 'package:dicoding_restaurant_app/models/food_model.dart';
import 'package:dicoding_restaurant_app/models/menu_model.dart';

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> restaurant) =>
      RestaurantModel(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'] != null
            ? double.parse(restaurant['rating'].toString())
            : 0,
        menus: restaurant['menus'] != null
            ? MenuModel.fromJson(restaurant['menus'])
            : MenuModel(drinks: <DrinkModel>[], foods: <FoodModel>[]),
      );

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final MenuModel menus;
}

List<RestaurantModel> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List data = parsed['restaurants'];
  return data.map((json) => RestaurantModel.fromJson(json)).toList();
}
