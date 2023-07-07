import 'dart:convert';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CountryApiService {


  Future<List<CountryModel>> fetchCountry() async {
    final response = await http.get(
        Uri.parse("https://popularkoju.com.np/countries.php"),
        headers: {"Accept": "application/json"});
    List<CountryModel> country = [];
    try {
      List<dynamic> values = jsonDecode(response.body);
      country = values.map((e) => CountryModel.fromJson(e)).toList();
      return country;
    } catch (e) {}
    return country;
  }
}
