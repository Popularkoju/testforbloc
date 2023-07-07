
import 'package:flutter_bloc/flutter_bloc.dart';

import '../State/homepage_controller_state.dart';
import '../State/homepage_controller_state.dart';

class HomepageControllerCubit extends Cubit<HomepageState> {
  HomepageControllerCubit() : super(HomepageState(pageIndex: 0));

  changePageIndex(int index) {
    emit(HomepageState(pageIndex: index));
  }
}
