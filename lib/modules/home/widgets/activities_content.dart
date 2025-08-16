import 'package:flutter/material.dart';

class ActivitiesContent extends StatelessWidget {
  const ActivitiesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Activities Content',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Add more widgets here as needed
      ],
    );
  }
}
