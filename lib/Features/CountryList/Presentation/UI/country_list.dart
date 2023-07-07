import 'package:countrylist/Features/CountryList/Presentation/UI/widgets/country_list_items.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CountryListItems()],
      ),
    );
  }
}
