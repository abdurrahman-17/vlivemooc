import 'dart:convert';

import 'category.dart';

class CategoryModel {
  List<Category>? categories;

  CategoryModel({this.categories});

  @override
  String toString() => 'CategoryModel(categories: $categories)';

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'categories': categories?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoryModel].
  factory CategoryModel.fromJson(String data) {
    return CategoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
