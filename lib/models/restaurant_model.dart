import 'dart:convert';

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
            ? Menus.fromJson(restaurant['menus'])
            : Menus(drinks: <Drinks>[], foods: <Foods>[]),
      );

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;
}

class Menus {
  Menus({required this.drinks, required this.foods});

  factory Menus.fromJson(Map<String, dynamic> menu) => Menus(
        drinks: menu['drinks'] != null
            ? (menu['drinks'] as List).map((e) => Drinks.fromJson(e)).toList()
            : <Drinks>[],
        foods: menu['foods'] != null
            ? (menu['foods'] as List).map((e) => Foods.fromJson(e)).toList()
            : <Foods>[],
      );

  final List<Foods> foods;
  final List<Drinks> drinks;
}

class Foods {
  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> food) =>
      Foods(name: food['name'] ?? '');

  final String name;
}

class Drinks {
  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> drink) =>
      Drinks(name: drink['name'] ?? '');

  final String name;
}

List<RestaurantModel> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List data = parsed['restaurants'];
  return data.map((json) => RestaurantModel.fromJson(json)).toList();
}
