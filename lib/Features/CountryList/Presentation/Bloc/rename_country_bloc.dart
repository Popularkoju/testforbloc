import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


part 'rename_country_event.dart';

part 'rename_country_state.dart';

class RenameCountryBloc extends Bloc<RenameCountryEvent, RenameCountryState> {
  RenameCountryBloc() : super(RenameCountryState(null)) {
    @override
    Stream<RenameCountryState> mapEventToState(
        RenameCountryEvent event) async* {
      if (event is SelectObjectEvent) {
        yield RenameCountryState(event.object);
      } else if (event is RenameObjectEvent) {
        final currentState = state;
        if (currentState.selectedCountry != null) {
          final updatedObject = CountryModel(event.newName);
          yield RenameCountryState(updatedObject);
        }
      }
    }

    on((event, emit) {
      // RenameCountryState(event);
      if (event is SelectObjectEvent) {
        emit(RenameCountryState(event.object));
      } else if (event is RenameObjectEvent) {
        final currentState = state;
        if (currentState.selectedCountry != null) {
          final updatedObject = CountryModel(event.newName);
          emit (RenameCountryState(updatedObject));
        }
      }
      // TODO: implement event handler
    });
  }
}
