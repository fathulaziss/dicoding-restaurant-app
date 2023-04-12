class CategoryModel {
  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(name: json['name'] ?? '');

  final String name;

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
