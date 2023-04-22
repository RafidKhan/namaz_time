import 'dart:developer';

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:namaz_time/app/models/namaz_time_model.dart';
import 'package:namaz_time/app/modules/home/repository/home_repository.dart';
import 'package:namaz_time/app/utils/common_methods.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  RxList<Country> listCountries = <Country>[].obs;
  RxList<NamazTimeModel> namazTimes = <NamazTimeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCountryList();
    checkMapPermission();
  }

  getCountryList() async {
    listCountries.value = await getCountries(Get.context!);
    listCountries.forEach((element) {
      log("DATA: ${element.countryCode}");
    });
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
    final bool hasPermission = await hasMapPermission(Get.context);
    if (hasPermission) {
      getCurrentPosition();
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
          log("COUNTRY:: ${place.isoCountryCode}");
          log("CITY:: ${place.locality}");
          if (place.isoCountryCode != null && place.locality != null) {
            getNamazTime(
              country: place.isoCountryCode!,
              city: place.locality!,
            );
          }
        }
      });
    } catch (e) {
      showSnackBar('something went wrong');
    }
  }

  Future getNamazTime({
    required String country,
    required String city,
  }) async {
    namazTimes.clear();
    try {
      final String year = DateTime.now().year.toString();
      final String month = DateTime.now().month.toString();
      final response = await _homeRepository.getNamazTime(
        year: year,
        month: month,
        city: "dhaka",
        country: 'bd',
      );

      if (response != null) {
        namazTimes.value = response;
      }
    } catch (e) {
      showSnackBar('something went wrong');
    }
  }
}
