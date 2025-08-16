import 'package:flutter/material.dart';
import 'package:executive_gps/modules/home/widgets/employee_tile.dart';

class EmployeesContent extends StatelessWidget {
  const EmployeesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 11,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return const EmployeeTile();
      },
    );
  }
}
