import 'package:flutter/material.dart';

class EmployeesContent extends StatelessWidget {
  const EmployeesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Employees Content',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Add more widgets here as needed
      ],
    );
  }
}
