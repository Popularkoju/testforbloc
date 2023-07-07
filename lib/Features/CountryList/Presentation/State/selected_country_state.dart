part of 'selected_country_cubit.dart';

class SelectedCountryBloc extends Equatable {
  CountryModel? _selectedObject;
  final _selectedObjectController = StreamController<CountryModel>.broadcast();

  Stream<CountryModel> get selectedObjectStream =>
      _selectedObjectController.stream;

  void selectObject(CountryModel? object) {
    if (object != null) {
      _selectedObject = object;
      _selectedObjectController.add(_selectedObject!);
    }
  }

  void renameObject(String newName) {
    if (_selectedObject != null) {
      _selectedObject!.name = newName;
      _selectedObjectController.add(_selectedObject!);
    }
  }

  void dispose() {
    _selectedObjectController.close();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedObjectStream, _selectedObject];
}
