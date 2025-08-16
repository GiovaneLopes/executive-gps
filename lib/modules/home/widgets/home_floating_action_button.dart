import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/home/blocs/home_bloc.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          onPressed: () {
            if (state.currentTab == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Activity Action Button Pressed')),
              );
            } else if (state.currentTab == 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Client Action Button Pressed')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Employee Action Button Pressed')),
              );
            }
          },
          child: const Icon(
            Icons.add,
            color: AppColors.black,
          ),
        );
      },
    );
  }
}
