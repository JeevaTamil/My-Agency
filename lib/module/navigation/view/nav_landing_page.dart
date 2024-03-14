import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_agency/module/navigation/cubit/navigation_cubit.dart';
import 'package:my_agency/module/navigation/model/nav_model.dart';
import 'package:my_agency/module/navigation/view/nav_bottom_bar.dart';
import 'package:my_agency/module/navigation/view/nav_rail.dart';


class NavLandingPage extends StatelessWidget {
  const NavLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LandingPage();
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 470) {
              return Row(
                children: [
                  NavRailWidget(
                    state: state,
                    constraints: constraints,
                  ),
                  Expanded(
                      child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: ExpandedPage(
                      colorScheme: colorScheme,
                      state: state,
                    ),
                  ))
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: ExpandedPage(
                        colorScheme: colorScheme,
                        state: state,
                      ),
                    ),
                  ),
                  NavBarWidget(state: state),
                ],
              );
            }
          },
        );
      },
    );
  }
}

class ExpandedPage extends StatelessWidget {
  const ExpandedPage({
    super.key,
    required this.colorScheme,
    required this.state,
  });

  final ColorScheme colorScheme;
  final state;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: NavModel.navModelList[state.navIndex].page,
      ),
    );
  }
}
