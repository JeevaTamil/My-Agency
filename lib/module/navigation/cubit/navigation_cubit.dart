import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationInitial(navIndex: 0));

  void updateNavigation(int navIndex) {
    emit(NavigationUpdated(navIndex: navIndex));
  }
}
