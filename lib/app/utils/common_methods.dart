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
  int? concatTimeInt;
  DateTime? dateTimeConverted;

  if (dateTime.contains("(")) {
    final String dateValue = dateTime.split("(").first.trim();
    dateTimeConverted = DateTime.parse(dateValue);
    String concatTime = dateTime.split("(").last;
    concatTime = concatTime.substring(0, concatTime.length - 1);
    concatTimeInt = int.parse(concatTime);
    dateTimeConverted = dateTimeConverted.add(Duration(hours: concatTimeInt));
  } else {
    dateTimeConverted = DateTime.parse(dateTime);
  }
  dateFormat = dateFormat ?? DateFormat('hh:mm a');
  return dateFormat.format(dateTimeConverted);
}
