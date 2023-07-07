import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'addcountrytolocal_event.dart';
part 'addcountrytolocal_state.dart';

class AddCountrytolocalBloc extends Bloc<AddcountrytolocalEvent, AddCountryState> {
 
  AddCountrytolocalBloc() : super(AddCountryState([] )) {
    // @override
    // Stream<AddCountryState> mapEventToState(AddCountryEvent event) async* {
    //   if (event is AddCountryEvent) {
    //     Hive.box<CountryModel>('countries').add(event.country);
    //     final updatedCountries = List<CountryModel>.from(Hive.box<CountryModel>('countries').values);
    //     yield AddCountryState(updatedCountries);
    //   }
    // }

    on<AddCountryEvent>((event, emit){
      // Hive.box<CountryModel>('countries').add(event.country);
      var countriesBox = Hive.box('countries');
      countriesBox.put(event.country.name, event.country);

      final updatedCountries = List<CountryModel>.from(countriesBox.values);
      emit(AddCountryState(updatedCountries));
    });
    on<GetCountryLocal>((event, emit){
      var countriesBox = Hive.box('countries');
      final updatedCountries = List<CountryModel>.from(countriesBox.values);
      emit(AddCountryState(updatedCountries));
    });

  }
}
