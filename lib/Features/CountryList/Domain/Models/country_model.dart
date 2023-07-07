import 'package:hive/hive.dart';
part 'country_model.g.dart';


@HiveType(typeId: 0)
class CountryModel extends HiveObject {
  @HiveField(0)
  String name;

  CountryModel(this.name);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(json["country_name"]);
  }
}
