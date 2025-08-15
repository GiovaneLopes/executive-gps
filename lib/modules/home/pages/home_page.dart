import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: Modular.get<AuthBloc>().logout,
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
