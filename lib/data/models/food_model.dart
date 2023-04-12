class FoodModel {
  FoodModel({required this.name});

  factory FoodModel.fromJson(Map<String, dynamic> food) =>
      FoodModel(name: food['name'] ?? '');

  final String name;

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
