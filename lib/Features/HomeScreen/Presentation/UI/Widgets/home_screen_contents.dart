import 'package:countrylist/Features/LocalCountry/Presentation/UI/local_country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../CountryList/Presentation/UI/widgets/country_list_items.dart';
import '../../Bloc/homepage_controller_cubit.dart';

class HomeScreenContents extends StatelessWidget {
  const HomeScreenContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index:context.watch<HomepageControllerCubit>().state.pageIndex,
        children: [
          const CountryListItems(),
         LocalCountryList(),
        ],
      ),
    );
  }
}
