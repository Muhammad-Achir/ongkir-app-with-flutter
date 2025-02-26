import 'dart:convert';

class City {
  String id;
  String name;
  String id_provinsi;

  City({
    required this.id,
    required this.name,
    required this.id_provinsi,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      id_provinsi: json['id_provinsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'id_provinsi': id_provinsi,
    };
  }

  
  static List<City> fromJsonList(List? data) {
    if (data == null || data.length == 0) {
      return [];
    }
    return data.map((e) => City.fromJson(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    // return 'Province{id: $id, name: $name}';
    return '$name';
  }
}
