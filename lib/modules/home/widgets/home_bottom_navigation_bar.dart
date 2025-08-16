import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/home/blocs/home_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          return BottomNavigationBar(
            unselectedItemColor: AppColors.grey,
            selectedItemColor: AppColors.black,
            currentIndex: state.currentTab,
            onTap: (index) => bloc.changeTab(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.list),
                label: 'Atividades',
                backgroundColor: AppColors.greyBackground,
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.mapPin),
                label: 'Clientes',
                backgroundColor: AppColors.greyBackground,
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.users),
                label: 'Colaboradores',
                backgroundColor: AppColors.greyBackground,
              ),
            ],
          );
        });
  }
}
