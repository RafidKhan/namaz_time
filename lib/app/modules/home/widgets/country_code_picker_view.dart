import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_time/app/modules/home/controllers/home_controller.dart';

class CountryCodePickerView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: controller.listCountries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.back(result: {
                'countryName': controller.listCountries[index].name,
                'countryCode': controller.listCountries[index].countryCode,
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    controller.listCountries[index].flag,
                    package: countryCodePackageName,
                    width: 20,
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.listCountries[index].countryCode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
