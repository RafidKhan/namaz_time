import 'package:get/get.dart';
import 'package:namaz_time/app/models/namaz_time_model.dart';
import 'package:namaz_time/app/utils/constants.dart';

class HomeRepository {
  final GetConnect _getConnect = GetConnect();

  Future<List<NamazTimeModel>?> getNamazTime({
    required String year,
    required String month,
    required String city,
    required String country,
  }) async {
    try {
      final url = namazTimeUrl
          .replaceAll('{YEAR}', year)
          .replaceAll('{MONTH}', month)
          .replaceAll('{CITY}', city)
          .replaceAll('{COUNTRY}', country);
      final response = await _getConnect.get(url);

      if (response.statusCode == 200) {
        final List timing = response.body['data'];
        final List<NamazTimeModel> namazTimes = <NamazTimeModel>[];

        timing.forEach((element) {
          final Map<String, dynamic> mapData = {
            'timings': element['timings'],
            'date': element['date']
          };

          namazTimes.add(NamazTimeModel.fromJson(mapData));
        });

        return namazTimes;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
