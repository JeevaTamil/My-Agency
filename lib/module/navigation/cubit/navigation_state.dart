part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {
  final int navIndex;
  const NavigationState({required this.navIndex});
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial({required super.navIndex});
}

final class NavigationUpdated extends NavigationState {
  const NavigationUpdated({required super.navIndex});
}
