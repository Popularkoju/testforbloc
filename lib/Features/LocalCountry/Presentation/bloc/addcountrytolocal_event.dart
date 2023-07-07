part of 'addcountrytolocal_bloc.dart';

@immutable
abstract class AddcountrytolocalEvent {}

class AddCountryEvent extends AddcountrytolocalEvent {
  final CountryModel country;

  AddCountryEvent(this.country);
}
class GetCountryLocal extends AddcountrytolocalEvent {
}