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
          centerTitle: true,
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.namazTimes.length,
          itemBuilder: (context, index) {
            final element = controller.namazTimes[index];
            return DataTile(
              namazTimeModel: element,
            );
          },
        ),
      );
    });
  }
}
