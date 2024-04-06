import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_agency/module/navigation/cubit/navigation_cubit.dart';
import 'package:my_agency/module/navigation/model/nav_model.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key, required this.state});
  final state;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: true,
      selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 5.0,
      backgroundColor: Theme.of(context).primaryColorDark,
      type: BottomNavigationBarType.fixed,
      items: NavModel.navModelList
          .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
          .toList(),
      currentIndex: state.navIndex,
      onTap: (value) {
        BlocProvider.of<NavigationCubit>(context).updateNavigation(value);
      },
    );
  }
}
