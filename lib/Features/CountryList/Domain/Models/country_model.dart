import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryModel extends Equatable{
  String name;

  CountryModel(this.name);

  factory CountryModel.fromJson(Map<String, dynamic> json) {

    return CountryModel(json["country_name"]);
  }

  @override
  // // TODO: implement props
  List<Object?> get props =>[name];

}
