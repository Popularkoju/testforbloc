import 'package:countrylist/Features/CountryList/Domain/Models/country_model.dart';
import 'package:flutter/material.dart';

import '../../Bloc/selected_country_cubit.dart';


class EditCountryName extends StatefulWidget {
  const EditCountryName({Key? key}) : super(key: key);

  @override
  State<EditCountryName> createState() => _EditCountryNameState();
}

class _EditCountryNameState extends State<EditCountryName> {
  final SelectedCountryBloc _objectBloc = SelectedCountryBloc();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CountryModel>(
      stream: _objectBloc.selectedObjectStream,
      builder: (context, snapshot) {
        print(snapshot?.data);
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No object selected'));
        }
        _nameController.text = snapshot.data!.name;
        return Column(
          children: [
            TextField(
              controller: _nameController,
              onSubmitted: (v){
                _objectBloc.renameObject(v);
              },
            )

          ],
        );
      }
    );
  }
}
