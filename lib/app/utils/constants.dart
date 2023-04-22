import 'package:namaz_time/app/models/month_model.dart';

const String namazTimeUrl =
    'http://api.aladhan.com/v1/calendarByCity/{YEAR}/{MONTH}?city={CITY}&country={COUNTRY}';

final List<MonthModel> listMonths = <MonthModel>[
  MonthModel(
    name: "January",
    value: "1",
  ),
  MonthModel(
    name: "February",
    value: "2",
  ),
  MonthModel(
    name: "March",
    value: "3",
  ),
  MonthModel(
    name: "April",
    value: "4",
  ),
  MonthModel(
    name: "May",
    value: "5",
  ),
  MonthModel(
    name: "June",
    value: "6",
  ),
  MonthModel(
    name: "July",
    value: "7",
  ),
  MonthModel(
    name: "August",
    value: "8",
  ),
  MonthModel(
    name: "September",
    value: "9",
  ),
  MonthModel(
    name: "October",
    value: "10",
  ),
  MonthModel(
    name: "November",
    value: "11",
  ),
  MonthModel(
    name: "December",
    value: "12",
  ),
];
