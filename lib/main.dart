import 'package:countrylist/Features/CountryList/Data/country_api_service.dart';
import 'package:countrylist/Features/CountryList/Presentation/State/countries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/CountryList/Presentation/State/selected_country_cubit.dart';
import 'Features/HomeScreen/Presentation/Controller/homepage_controller_cubit.dart';
import 'Features/HomeScreen/Presentation/UI/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final CountriesBloc countryBloc = CountriesBloc();
    countryBloc.add(GetCountryList());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomepageControllerCubit()),
        BlocProvider(create: (_) => countryBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
