import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:countrylist/Features/LocalCountry/Presentation/bloc/addcountrytolocal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LocalCountryList extends StatefulWidget {
  const LocalCountryList({Key? key}) : super(key: key);

  @override
  State<LocalCountryList> createState() => _LocalCountryListState();
}

class _LocalCountryListState extends State<LocalCountryList> {



  List<CountryModel> countries = [];

  @override
  // void initState() {
  //   print("level 1");
  //   var countriesBox = Hive.box('countries');
  //   countries = countriesBox.values.cast<CountryModel>().toList();
  //   // Print the retrieved data
  //   countries.forEach((country) {
  //     print(country.name);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final AddCountrytolocalBloc countryBloc = AddCountrytolocalBloc();
    countryBloc.add(GetCountryLocal());
    return SafeArea(
        child: Scaffold(
          body: BlocBuilder<AddCountrytolocalBloc, AddCountryState>(
            bloc:  countryBloc,
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.countries.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(state.countries[index].name),
                            ),
                          );
                        }),

                  )
                ],
              );
            },
          ),
        ));
  }
}
