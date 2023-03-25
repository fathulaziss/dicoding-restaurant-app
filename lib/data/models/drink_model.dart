class DrinkModel {
  DrinkModel({required this.name});

  factory DrinkModel.fromJson(Map<String, dynamic> drink) =>
      DrinkModel(name: drink['name'] ?? '');

  final String name;
}
