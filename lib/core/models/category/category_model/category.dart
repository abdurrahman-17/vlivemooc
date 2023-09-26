import 'dart:convert';

class Category {
  String? idgenre;
  String? title;
  String? icon;
  String? description;
  int? weight;
  String? initiatedby;
  String? updatedby;
  String? created;
  String? updatedon;

  Category({
    this.idgenre,
    this.title,
    this.icon,
    this.description,
    this.weight,
    this.initiatedby,
    this.updatedby,
    this.created,
    this.updatedon,
  });

  @override
  String toString() {
    return 'Category(idgenre: $idgenre, title: $title, icon: $icon, description: $description, weight: $weight, initiatedby: $initiatedby, updatedby: $updatedby, created: $created, updatedon: $updatedon)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        idgenre: data['idgenre'] as String?,
        title: data['title'] as String?,
        icon: data['icon'] as String?,
        description: data['description'] as String?,
        weight: data['weight'] as int?,
        initiatedby: data['initiatedby'] as String?,
        updatedby: data['updatedby'] as String?,
        created: data['created'] as String?,
        updatedon: data['updatedon'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'idgenre': idgenre,
        'title': title,
        'icon': icon,
        'description': description,
        'weight': weight,
        'initiatedby': initiatedby,
        'updatedby': updatedby,
        'created': created,
        'updatedon': updatedon,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());
}
