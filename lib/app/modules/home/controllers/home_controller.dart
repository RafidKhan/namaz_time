import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:namaz_time/app/models/namaz_time_model.dart';
import 'package:namaz_time/app/modules/home/repository/home_repository.dart';
import 'package:namaz_time/app/modules/home/widgets/adress_input_view.dart';
import 'package:namaz_time/app/modules/home/widgets/country_code_picker_view.dart';
import 'package:namaz_time/app/utils/common_methods.dart';
import 'package:namaz_time/app/utils/constants.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  RxList<Country> listCountries = <Country>[].obs;
  RxList<NamazTimeModel> namazTimes = <NamazTimeModel>[].obs;

  RxBool loader = true.obs;

  Rxn<String> selectedAddress = Rxn<String>();
  Rxn<String> selectedMonth = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    getCountryList();
    checkMapPermission();
  }

  getCountryList() async {
    listCountries.value = await getCountries(Get.context!);
  }

  Future<bool> hasMapPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future checkMapPermission() async {
    loader.value = true;
    final bool hasPermission = await hasMapPermission(Get.context);
    if (hasPermission) {
      getCurrentPosition();
    } else {
      loader.value = false;
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placeMarks) {
        if (placeMarks.isNotEmpty) {
          final Placemark place = placeMarks.first;
          if (place.isoCountryCode != null && place.locality != null) {
            getNamazTime(
              country: place.country ?? "",
              countryCode: place.isoCountryCode!,
              city: place.locality!,
            );
          }
        }
      });
    } catch (e) {
      loader.value = false;
      showSnackBar('something went wrong');
    }
  }

  Future getNamazTime({
    required String country,
    required String countryCode,
    required String city,
    String? getYear,
    String? getMonth,
  }) async {
    loader.value = true;
    selectedAddress.value = country;
    if (city.isNotEmpty) {
      selectedAddress.value = "${selectedAddress.value}, $city";
    }
    namazTimes.clear();
    try {
      final String year = getYear ?? DateTime.now().year.toString();
      final String month = getMonth ?? DateTime.now().month.toString();
      final selectedMonthIndex =
          listMonths.indexWhere((element) => element.value == month);

      selectedMonth.value = listMonths[selectedMonthIndex].name;

      final response = await _homeRepository.getNamazTime(
        year: year,
        month: month,
        city: city,
        country: country,
      );

      if (response != null) {
        namazTimes.value = response;
        loader.value = false;
      }
    } catch (e) {
      loader.value = false;
      showSnackBar('something went wrong');
    }
  }

  Future selectCountryBottomSheet() async {
    final countryData = await showModalBottomSheet(
      context: Get.context!,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.grey[200],
      builder: (builder) {
        return CountryCodePickerView();
      },
    );
    if (countryData != null) {
      final String countryName = countryData['countryName'];
      final String countryCode = countryData['countryCode'];
      enterAddressBottomSheet(
          countryName: countryName, countryCode: countryCode);
    }
  }

  Future enterAddressBottomSheet({
    required String countryName,
    required String countryCode,
  }) async {
    showModalBottomSheet(
      context: Get.context!,
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
}
