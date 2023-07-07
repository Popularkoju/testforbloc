part of 'rename_country_bloc.dart';

@immutable
abstract class RenameCountryEvent extends Equatable {}
class SelectObjectEvent extends RenameCountryEvent {
  final CountryModel object;

  SelectObjectEvent(this.object);

  @override
  // TODO: implement props
  List<Object?> get props => [object];
}

class RenameObjectEvent extends RenameCountryEvent {
  final String newName;
  RenameObjectEvent(this.newName);

  @override
  // TODO: implement props
  List<Object?> get props => [newName];
}