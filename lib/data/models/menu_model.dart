import 'package:dicoding_restaurant_app/data/models/drink_model.dart';
import 'package:dicoding_restaurant_app/data/models/food_model.dart';

class MenuModel {
  MenuModel({required this.drinks, required this.foods});

  factory MenuModel.fromJson(Map<String, dynamic> menu) => MenuModel(
        drinks: menu['drinks'] != null
            ? (menu['drinks'] as List)
                .map((e) => DrinkModel.fromJson(e))
                .toList()
            : <DrinkModel>[],
        foods: menu['foods'] != null
            ? (menu['foods'] as List).map((e) => FoodModel.fromJson(e)).toList()
            : <FoodModel>[],
      );

  final List<FoodModel> foods;
  final List<DrinkModel> drinks;

  Map<String, dynamic> toJson() => {
        'foods': List<String>.from(foods.map((e) => e.toJson())),
        'drinks': List<String>.from(drinks.map((e) => e.toJson())),
      };
}
