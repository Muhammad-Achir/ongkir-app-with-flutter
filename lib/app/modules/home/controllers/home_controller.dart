import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/shipping_cost_model.dart';

class HomeController extends GetxController {
  final String apiKey =
      '7be3f9dcf19651815e58f0633deb22148dc49ff022cf62a8ca4e6209d7ee3917';

  RxBool isLoading = false.obs;
  TextEditingController weightController = TextEditingController();
  RxString originProvinceId = '11'.obs;
  RxString originCityName = 'KOTA MAKASSAR'.obs;
  RxString destinationProvinceId = '11'.obs;
  RxString destinationCityName = 'KAB. MAMUJU'.obs;
  RxString courierCode = 'pos'.obs;

  void checkShippingCost() async {
    if (weightController.text != '' &&
        originCityName.value != '' &&
        destinationCityName != '' &&
        courierCode.value != '') {
      print('object');
      debugPrint('test');
      try {
        isLoading.value = true;
        // var response = await Dio().get(
        //         'https://api.binderbyte.com/wilayah/kabupaten?api_key=${apiKey}&id_provinsi=${controller.destinationProvinceId}',
        //       );
        // return City.fromJsonList(response.data['value']);

        var response = await Dio().get(
          'https://api.binderbyte.com/v1/cost',
          queryParameters: {
            'api_key': apiKey,
            'courier': courierCode.value,
            'origin': originCityName.value,
            'destination': destinationCityName.value,
            'weight': weightController.text,
          },
        );

        isLoading.value = false;
        // print(response);
        // List costJsonList = json.decode(response.data)['data']['costs'] as List;
        List<ShippingCost> costList =
            ShippingCost.fromJsonList(response.data['data']['costs']);

        Get.defaultDialog(
          title: 'List Shipping Cost',
          content: Container(
            constraints: BoxConstraints(
              maxHeight: 300, // Batasi tinggi maksimal dialog
            ),
            child: SingleChildScrollView(
              child: Column(
                children: costList
                    .map((e) => ListTile(
                          title: Text(
                            e.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                              '${e.type} - ${e.estimated} \nRp ${e.price}'),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      } catch (e) {
        isLoading.value = false;

        Get.defaultDialog(
          title: 'Something went Wrong in request',
          middleText: '$e',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Something went Wrong',
        middleText: 'Please fill all field',
      );
    }
  }
}
