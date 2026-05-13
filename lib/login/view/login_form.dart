import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';

import '../../register/view/register_page.dart';
import '../../authentication/repository/authentication_repository.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },

      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Card(
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(Icons.lock, size: 80),

                        const SizedBox(height: 20),

                        const Text(
                          'Firebase Login',

                          style: TextStyle(
                            fontSize: 28,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // EMAIL
                        CustomTextField(
                          controller: emailController,

                          label: 'Email',

                          onChanged: (value) {
                            context.read<LoginCubit>().emailChanged(value);
                          },

                          errorText: state.email.displayError != null
                              ? 'Email tidak valid'
                              : null,
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD
                        CustomTextField(
                          controller: passwordController,

                          label: 'Password',

                          obscureText: true,

                          onChanged: (value) {
                            context.read<LoginCubit>().passwordChanged(value);
                          },

                          errorText: state.password.displayError != null
                              ? 'Password minimal 6 karakter'
                              : null,
                        ),

                        const SizedBox(height: 30),

                        // LOGIN BUTTON
                        CustomButton(
                          text: 'Login',

                          isLoading:
                              state.status == FormzSubmissionStatus.inProgress,

                          onPressed: !state.isValid
                              ? null
                              : () {
                                  context.read<LoginCubit>().logIn();
                                },
                        ),

                        const SizedBox(height: 20),

                        // REGISTER BUTTON
                        SizedBox(
                          width: double.infinity,

                          height: 50,

                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => RegisterPage(
                                    authenticationRepository:
                                        AuthenticationRepository(),
                                  ),
                                ),
                              );
                            },

                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}