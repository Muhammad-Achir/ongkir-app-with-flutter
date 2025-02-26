import 'package:meta/meta.dart';
import 'dart:convert';

class ShippingCost {
  String code;
  String name;
  String service;
  String type;
  String price;
  String estimated;

  ShippingCost({
    required this.code,
    required this.name,
    required this.service,
    required this.type,
    required this.price,
    required this.estimated,
  });

  factory ShippingCost.fromRawJson(String str) =>
      ShippingCost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingCost.fromJson(Map<String, dynamic> json) => ShippingCost(
        code: json["code"],
        name: json["name"],
        service: json["service"],
        type: json["type"],
        price: json["price"],
        estimated: json["estimated"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "service": service,
        "type": type,
        "price": price,
        "estimated": estimated,
      };

  static List<ShippingCost> fromJsonList(List? data) {
    if (data == null || data.length == 0) {
      return [];
    }
    return data.map((e) => ShippingCost.fromJson(e)).toList();
  }
}
