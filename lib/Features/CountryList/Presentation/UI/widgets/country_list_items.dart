import 'package:countrylist/Features/CountryList/Data/country_api_service.dart';
import 'package:countrylist/Features/CountryList/Presentation/UI/widgets/edit_country_name.dart';
import 'package:countrylist/Features/LocalCountry/Presentation/bloc/addcountrytolocal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../Domain/Models/country_model.dart';
import '../../Bloc/countries_bloc.dart';
import '../../Bloc/rename_country_bloc.dart';
import '../../Bloc/selected_country_cubit.dart';

class CountryListItems extends StatefulWidget {
  const CountryListItems({Key? key}) : super(key: key);

  @override
  State<CountryListItems> createState() => _CountryListItemsState();
}

class _CountryListItemsState extends State<CountryListItems> {
  final RenameCountryBloc _objectBloc = RenameCountryBloc();
  final SelectedCountryBloc _selectedCountryBloc = SelectedCountryBloc();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountriesBloc, CountriesState>(
      listener: (context, state) {
        if (state is CountryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
      },
      builder: (ctx, state) {
        if (state is CountriesInitial) {
          return buildCircular();
        } else if (state is CountryLoading) {
          return buildCircular();
        } else if (state is CountryLoaded) {
          return blockBuild(ctx, state.countryModel);
        } else if (state is CountryError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget blockBuild(BuildContext ctx, List<CountryModel> countries) {
    return Column(
      children: [
        Flexible(
            child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        _objectBloc.add(SelectObjectEvent(countries[index]));
                        // _objectBloc.(countries[index]);
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              _nameController.text =
                                  _objectBloc.state.selectedCountry!.name;
                              return BlocBuilder<RenameCountryBloc,
                                  RenameCountryState>(
                                bloc: _objectBloc,
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _nameController,
                                          onSubmitted: (v) {
                                            _objectBloc
                                                .add(RenameObjectEvent(v));
                                            AddCountrytolocalBloc local =
                                                AddCountrytolocalBloc();
                                            local.add(AddCountryEvent(
                                                CountryModel(v)));
                                            // var countriesBox = Hive.box('countries');
                                            // CountryModel country = CountryModel(v);
                                            // countriesBox.put(v,country);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                  print(state.selectedCountry?.name);

                                  // _nameController.text = state.selectedCountry!.name.toString();
                                },
                              );
                            });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    offset: const Offset(0, 2))
                              ]),
                          child: ListTile(
                              title: Text(
                            countries[index].name,
                            style: const TextStyle(fontSize: 16),
                          ))),
                    ))),
      ],
    );
  }

  Widget buildList(
      BuildContext ctx, List<CountryModel> countries, CountriesState state) {
    return Column(children: [
      Flexible(
          child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (_, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: StreamBuilder<CountryModel>(
                      stream: _selectedCountryBloc.selectedObjectStream,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            _selectedCountryBloc.selectObject(countries[index]);

                            if (_selectedCountryBloc.selectedObjectStream !=
                                null) {
                              if (snapshot.hasData && snapshot.data != null) {
                                // _nameController.text = snapshot.data!.name;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      _nameController.text =
                                          snapshot.data!.name;
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 24,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _nameController,
                                              onSubmitted: (v) {
                                                _objectBloc
                                                    .add(RenameObjectEvent(v));
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.2),
                                        offset: const Offset(0, 2))
                                  ]),
                              child: ListTile(
                                  leading: Text(
                                countries[index].name,
                                style: const TextStyle(fontSize: 16),
                              ))),
                        );
                      },
                    ),
                  ))),
    ]);
  }

  Widget buildCircular() => const Center(
        child: CircularProgressIndicator(),
      );
}
