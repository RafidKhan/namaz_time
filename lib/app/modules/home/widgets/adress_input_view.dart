import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_time/app/models/month_model.dart';
import 'package:namaz_time/app/modules/home/controllers/home_controller.dart';
import 'package:namaz_time/app/utils/constants.dart';

class AdressInputView extends StatefulWidget {
  final String countryCode;
  final String countryName;

  const AdressInputView({
    Key? key,
    required this.countryCode,
    required this.countryName,
  }) : super(key: key);

  @override
  State<AdressInputView> createState() => _AdressInputViewState();
}

class _AdressInputViewState extends State<AdressInputView> {
  final HomeController controller = Get.find<HomeController>();
  TextEditingController addressController = TextEditingController();

  String? selectedMonthValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        right: 16,
        left: 16,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text(
              "Input District Name",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: addressController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Input District Name",
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Obx(() {
              return DropdownButton(
                value: controller.selectedMonth.value ?? "",
                icon: const Icon(Icons.keyboard_arrow_down),
                items: listMonths.map((MonthModel monthModel) {
                  return DropdownMenuItem(
                    value: monthModel.name,
                    child: Text(monthModel.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.selectedMonth.value = newValue;
                  final selectedMonthIndex = listMonths
                      .indexWhere((element) => element.name == newValue);
                  selectedMonthValue = listMonths[selectedMonthIndex].value;
                },
              );
            }),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                final String address = addressController.text.trim();
                Get.back();
                controller.getNamazTime(
                  country: widget.countryName,
                  countryCode: widget.countryCode,
                  city: address,
                  // getYear: year,
                  getMonth: selectedMonthValue,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: const Text("Enter"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
