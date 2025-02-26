import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/data/models/city_model.dart';
import 'package:ongkir/app/data/models/province_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  String? idProvince;
  final String apiKey =
      '7be3f9dcf19651815e58f0633deb22148dc49ff022cf62a8ca4e6209d7ee3917';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Cost Send'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            // Select province
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Origin Province',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            items: (text, prop) async {
              var response = await Dio().get(
                'https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey',
              );
              return Province.fromJsonList(response.data['value']);
              // return [];
            },
            popupProps: PopupProps.menu(
              // title: Text('data'),
              // disabledItemFn: (item) => item == 'Item 3',
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected, isDisable) {
                return ListTile(
                  title: Text(item.name),
                );
              },
            ),
            onChanged: (value) {
              // print(value?.id);
              //  idProvince = value?.id;
              controller.originProvinceId.value = value?.id ?? '';
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.name ?? '');
            },
            compareFn: (Province a, Province b) => a.id == b.id,
          ),
          SizedBox(height: 20),
          DropdownSearch<City>(
            // Select city
            items: (text, prop) async {
              var response = await Dio().get(
                'https://api.binderbyte.com/wilayah/kabupaten?api_key=${apiKey}&id_provinsi=${controller.originProvinceId}',
              );
              return City.fromJsonList(response.data['value']);
              // return [];
            },
            popupProps: PopupProps.menu(
              // disabledItemFn: (item) => item == 'Item 3',
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected, isDisable) {
                return ListTile(
                  title: Text(item.name),
                );
              },
            ),
            onChanged: (value) {
              // print(value?.id);
              controller.originCityName.value = value?.name ?? '';
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? 'Select City'),
            compareFn: (City a, City b) => a.id == b.id,
          ),
          SizedBox(height: 20),
          Divider(height: 20),
          SizedBox(height: 20),
          DropdownSearch<Province>(
            // Select destination province
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Destination Province',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            items: (text, prop) async {
              var response = await Dio().get(
                'https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey',
              );
              return Province.fromJsonList(response.data['value']);
              // return [];
            },
            popupProps: PopupProps.menu(
              // title: Text('data'),
              // disabledItemFn: (item) => item == 'Item 3',
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected, isDisable) {
                return ListTile(
                  title: Text(item.name),
                );
              },
            ),
            onChanged: (value) {
              // print(value?.id);
              //  idProvince = value?.id;
              controller.destinationProvinceId.value = value?.id ?? '';
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.name ?? '');
            },
            compareFn: (Province a, Province b) => a.id == b.id,
          ),
          SizedBox(height: 20),
          DropdownSearch<City>(
            // Select city
            items: (text, prop) async {
              var response = await Dio().get(
                'https://api.binderbyte.com/wilayah/kabupaten?api_key=${apiKey}&id_provinsi=${controller.destinationProvinceId}',
              );
              return City.fromJsonList(response.data['value']);
              // return [];
            },
            popupProps: PopupProps.menu(
              // disabledItemFn: (item) => item == 'Item 3',
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected, isDisable) {
                return ListTile(
                  title: Text(item.name),
                );
              },
            ),
            onChanged: (value) {
              // print(value?.id);
              controller.destinationCityName.value = value?.name ?? '';
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? 'Select City'),
            compareFn: (City a, City b) => a.id == b.id,
          ),
          SizedBox(height: 20),
          TextField(
            textInputAction: TextInputAction.next,
            controller: controller.weightController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight',
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<Map<String, dynamic>>(
            items: (text, props) {
              return [
                {
                  'code': 'jne',
                  'name': 'JNE',
                },
                {
                  'code': 'sicepat',
                  'name': 'Sicepat',
                },
                {
                  'code': 'lion',
                  'name': 'Lion',
                },
                {
                  'code': 'pos',
                  'name': 'POS',
                },
              ];
            },
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Select Courier',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              fit: FlexFit.loose,
              itemBuilder: (context, item, isDisabled, isSelected) {
                return ListTile(
                  title: Text(item['name']),
                );
              },
            ),
            onChanged: (value) {
              // print(value?['code']);
              controller.courierCode.value = value?['code'];
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?['name'] ?? '');
            },
            compareFn: (Map<String, dynamic> a, Map<String, dynamic> b) =>
                a['code'] == b['code'],
          ),
          SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      controller.checkShippingCost();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text('Check Shipping Cost'),
            ),
          ),
        ],
      ),
    );
  }
}
