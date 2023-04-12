// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dicoding_restaurant_app/data/models/category_model.dart';
import 'package:dicoding_restaurant_app/data/models/customer_review_model.dart';
import 'package:dicoding_restaurant_app/data/models/menu_model.dart';

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> restaurant) =>
      RestaurantModel(
        id: restaurant['id'] ?? '',
        name: restaurant['name'] ?? '',
        description: restaurant['description'] ?? '',
        pictureId: restaurant['pictureId'] ?? '',
        city: restaurant['city'] ?? '',
        categories: restaurant['categories'] != null
            ? List<CategoryModel>.from(
                (restaurant['categories'] as List)
                    .map((e) => CategoryModel.fromJson(e)),
              )
            : [],
        menus: restaurant['menus'] != null
            ? MenuModel.fromJson(restaurant['menus'])
            : MenuModel(drinks: [], foods: []),
        rating: restaurant['rating'] != null
            ? double.parse(restaurant['rating'].toString())
            : 0,
        customerReviews: restaurant['customerReviews'] != null
            ? List<CustomerReviewModel>.from(
                (restaurant['customerReviews'] as List)
                    .map((e) => CustomerReviewModel.fromJson(e)),
              )
            : [],
      );

  factory RestaurantModel.fromMapDatabase(Map<String, dynamic> restaurant) =>
      RestaurantModel(
        id: restaurant['id'] ?? '',
        name: restaurant['name'] ?? '',
        description: restaurant['description'] ?? '',
        pictureId: restaurant['pictureId'] ?? '',
        city: restaurant['city'] ?? '',
        categories: jsonDecode(restaurant['categories']) != null
            ? List<CategoryModel>.from(
                (jsonDecode(restaurant['categories']) as List)
                    .map((e) => CategoryModel.fromJson(e)),
              )
            : [],
        menus: jsonDecode(restaurant['menus']) != null
            ? MenuModel.fromJson(jsonDecode(restaurant['menus']))
            : MenuModel(drinks: [], foods: []),
        rating: restaurant['rating'] != null
            ? double.parse(restaurant['rating'].toString())
            : 0,
        customerReviews: jsonDecode(restaurant['customerReviews']) != null
            ? List<CustomerReviewModel>.from(
                (jsonDecode(restaurant['customerReviews']) as List)
                    .map((e) => CustomerReviewModel.fromJson(e)),
              )
            : [],
      );

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final List<CategoryModel> categories;
  final MenuModel menus;
  final double rating;
  final List<CustomerReviewModel> customerReviews;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'categories': categories,
        'menus': menus.toJson(),
        'rating': rating,
        'customerReviews': customerReviews,
      };

  Map<String, dynamic> toMapDatabase() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'categories':
            jsonEncode(List<String>.from(categories.map((e) => e.toJson()))),
        'menus': jsonEncode(menus.toJson()),
        'rating': rating,
        'customerReviews': jsonEncode(
          List<String>.from(customerReviews.map((e) => e.toJson())),
        ),
      };
}

List<RestaurantModel> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List data = parsed['restaurants'];
  return data.map((json) => RestaurantModel.fromJson(json)).toList();
}
