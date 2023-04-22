import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

showSnackBar(String text) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

String convertDateTime({
  required String dateTime,
  DateFormat? dateFormat,
}) {
  try {
    final DateTime dateTimeConverted = DateTime.parse(dateTime);
    dateFormat = dateFormat ?? DateFormat('hh:mm a');
    return dateFormat.format(dateTimeConverted);
  } catch (e) {
    return dateTime;
  }
}
