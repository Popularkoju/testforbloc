import 'package:countrylist/Features/CountryList/Data/country_api_service.dart';
import 'package:countrylist/Features/CountryList/Presentation/State/countries_bloc.dart';
import 'package:countrylist/Features/CountryList/Presentation/State/rename_country_bloc.dart';
import 'package:countrylist/Features/CountryList/Presentation/State/selected_country_cubit.dart';
import 'package:countrylist/Features/CountryList/Presentation/UI/widgets/edit_country_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Models/country_model.dart';

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
                              return BlocBuilder<RenameCountryBloc,
                                  RenameCountryState>(
                                bloc: _objectBloc,
                                builder: (context, state) {
                                  if(state is RenameCountryState){
                                    print(state.selectedCountry);
                                    _nameController.text = state.selectedCountry!.name;

                                    return Column(
                                      children: [
                                        SizedBox(height: 24,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _nameController,
                                            onSubmitted: (v) {
                                              _objectBloc.add(RenameObjectEvent(v));
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                    print(state.selectedCountry?.name);
                                  }else{
                                    return Container();
                                  }

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
                              leading: Text(
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

                            if (_selectedCountryBloc.selectedObjectStream != null) {
                              if(snapshot.hasData && snapshot.data!=null){
                                // _nameController.text = snapshot.data!.name;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {

                                      _nameController.text = snapshot.data!.name;
                                      return Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          TextField(
                                            controller: _nameController,
                                            onSubmitted: (v) {
                                              _selectedCountryBloc.renameObject(v);
                                              Navigator.of(context).pop();
                                            },
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
