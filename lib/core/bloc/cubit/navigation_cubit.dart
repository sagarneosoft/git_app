import 'package:bloc/bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.initial());

  void onTap(int index) {
    emit(state.copyWith(index: index));
  }
}
