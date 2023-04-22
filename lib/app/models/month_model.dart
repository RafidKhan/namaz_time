class MonthModel {
  final String name;
  final String value;

  MonthModel({
    required this.name,
    required this.value,
  });

  MonthModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };
}
