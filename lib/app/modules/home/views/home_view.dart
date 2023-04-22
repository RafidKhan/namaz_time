import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              onPressed: () {
                controller.selectCountryBottomSheet();
              },
              icon: const Icon(
                Icons.filter_alt,
              ),
            ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  controller.selectedAddress.value ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
