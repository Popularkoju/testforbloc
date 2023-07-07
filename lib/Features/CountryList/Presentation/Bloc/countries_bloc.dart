import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../Domain/Models/country_model.dart';
import '../../repo/ApiRepository.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc() : super(CountriesInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on((event, emit) async {
      try {
        emit(CountryLoading());
        final mList = await _apiRepository.fetchCountryList();
        emit(CountryLoaded(mList));
        if (mList==null) {
          emit(CountryError("NO DATA"));
        }
      } on NetworkError {
        emit(CountryError("Failed to fetch data. is your device online?"));
      }
    });

    // on<SelectedCountryEvent>((event, emit){
    //   emit(SelectedCountryState(CountryModel("hello")));
    //
    // });
  }



}
