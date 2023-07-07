part of 'countries_bloc.dart';

@immutable
abstract class CountriesEvent extends Equatable {


@override
List<Object> get props => [];


}

class GetCountryList extends CountriesEvent{
}

class SelectedCountryEvent extends CountriesEvent{
  CountryModel? get selectedCountry => selectedCountry;


}

