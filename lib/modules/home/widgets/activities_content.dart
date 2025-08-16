import 'package:flutter/material.dart';
import 'package:executive_gps/modules/home/widgets/activity_tile.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class ActivitiesContent extends StatelessWidget {
  const ActivitiesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBackground,
      child: ListView(
        children: List.generate(11, (index) {
          return const ActivityCard();
        }),
      ),
    );
  }
}
