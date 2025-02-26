import 'dart:convert';

class Province {
  Province({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<Province> fromJsonList(List? data) {
    if (data == null || data.length == 0) {
      return [];
    }
    return data.map((e) => Province.fromJson(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    // return 'Province{id: $id, name: $name}';
    return '$name';
  }
}
