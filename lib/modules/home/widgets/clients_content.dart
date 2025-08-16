import 'package:flutter/material.dart';

class ClientsContent extends StatelessWidget {
  const ClientsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Clients Content',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Add more widgets here as needed
      ],
    );
  }
}
