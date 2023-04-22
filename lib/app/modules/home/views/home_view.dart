import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:namaz_time/app/modules/home/widgets/adress_input_view.dart';
import 'package:namaz_time/app/modules/home/widgets/country_code_picker_view.dart';
import 'package:namaz_time/app/modules/home/widgets/data_time.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Namaz Time'),
          actions: [
            IconButton(
              onPressed: () async {
                final countryData = await showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.grey[200],
                  builder: (builder) {
                    return CountryCodePickerView();
                  },
                );
                if (countryData != null) {
                  final String countryName = countryData['countryName'];
                  final String countryCode = countryData['countryCode'];
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.grey[200],
                    builder: (builder) {
                      return AdressInputView(
                        countryName: countryName,
                        countryCode: countryCode,
                      );
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.filter_alt,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            if (controller.loader.isTrue) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            if (controller.loader.isFalse) ...[
              Text(controller.selectedAddress.value ?? ""),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.namazTimes.length,
                  itemBuilder: (context, index) {
                    final element = controller.namazTimes[index];
                    return DataTile(
                      namazTimeModel: element,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
