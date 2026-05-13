import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';

import 'login_form.dart';

import '../../authentication/repository/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const LoginPage({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      body: BlocProvider(
        create: (_) =>
            LoginCubit(authenticationRepository: authenticationRepository),

        child: LoginForm(),
      ),
    );
  }
}