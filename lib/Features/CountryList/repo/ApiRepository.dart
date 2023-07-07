import 'package:countrylist/Features/CountryList/Data/country_api_service.dart';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';

class ApiRepository {
  CountryApiService countryApiService = CountryApiService();

  Future<List<CountryModel>> fetchCountryList() async {
    return countryApiService.fetchCountry();
  }
}

class NetworkError extends Error {}