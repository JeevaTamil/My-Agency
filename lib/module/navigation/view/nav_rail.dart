import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_agency/module/navigation/cubit/navigation_cubit.dart';
import 'package:my_agency/module/navigation/model/nav_model.dart';

class NavRailWidget extends StatelessWidget {
  const NavRailWidget(
      {super.key, required this.state, required this.constraints});
  final state;
  final constraints;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: Theme.of(context).primaryColorDark,
      extended: constraints.maxWidth >= 600,
      elevation: 55.0,
      destinations: NavModel.navModelList
          .map((e) =>
              NavigationRailDestination(icon: e.icon, label: Text(e.label)))
          .toList(),
      selectedIndex: state.navIndex,
      onDestinationSelected: (value) {
        BlocProvider.of<NavigationCubit>(context).updateNavigation(value);
      },
    );
  }
}
