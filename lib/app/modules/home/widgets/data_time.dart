import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namaz_time/app/models/namaz_time_model.dart';
import 'package:namaz_time/app/utils/common_methods.dart';

class DataTile extends StatelessWidget {
  final NamazTimeModel namazTimeModel;

  const DataTile({
    Key? key,
    required this.namazTimeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isToday() ? Colors.grey[400] : Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            namazTimeModel.date.readable,
            style: TextStyle(
              fontSize: isToday() ? 25 : 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("FAJR: ${namazTimeModel.timings.fajr}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("DHUHR: ${namazTimeModel.timings.dhuhr}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("ASR: ${namazTimeModel.timings.asr}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("MAGHRIB: ${namazTimeModel.timings.maghrib}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("ISHA: ${namazTimeModel.timings.isha}"),
          ),
        ],
      ),
    );
  }

  bool isToday() {
    if (convertDateTime(
          dateTime: DateTime.now().toString(),
          dateFormat: DateFormat('d MMM yyy'),
        ).trim() ==
        namazTimeModel.date.readable.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
