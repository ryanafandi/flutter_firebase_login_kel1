import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/register_cubit.dart';

import 'register_form.dart';

import '../../authentication/repository/authentication_repository.dart';

class RegisterPage extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const RegisterPage({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),

      body: BlocProvider(
        create: (_) =>
            RegisterCubit(authenticationRepository: authenticationRepository),

        child: RegisterForm(),
      ),
    );
  }
}