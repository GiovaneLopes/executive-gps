import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/home/blocs/home_bloc.dart';
import 'package:executive_gps/modules/home/widgets/home_appbar.dart';
import 'package:executive_gps/modules/home/widgets/home_drawer.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/home/widgets/clients_content.dart';
import 'package:executive_gps/modules/home/widgets/employees_content.dart';
import 'package:executive_gps/modules/home/widgets/activities_content.dart';
import 'package:executive_gps/modules/home/widgets/home_bottom_navigation_bar.dart';
import 'package:executive_gps/modules/home/widgets/home_floating_action_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<HomeBloc>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.white,
          appBar: HomeAppBar(scaffoldKey: scaffoldKey),
          drawer: const HomeDrawer(),
          floatingActionButton: const HomeFloatingActionButton(),
          bottomNavigationBar: const HomeBottomNavigationBar(),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: state.currentTab == 0
                      ? const ActivitiesContent()
                      : state.currentTab == 1
                          ? const ClientsContent()
                          : const EmployeesContent(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
