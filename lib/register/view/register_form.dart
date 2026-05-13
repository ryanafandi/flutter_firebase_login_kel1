import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../login/view/login_page.dart';
import '../../authentication/repository/authentication_repository.dart';

import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }

        if (state.status == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Register berhasil 🎉')));
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        }
      },

      child: BlocBuilder<RegisterCubit, RegisterState>(
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
                        const Icon(Icons.person_add, size: 80),

                        const SizedBox(height: 20),

                        const Text(
                          'Create Account',

                          style: TextStyle(
                            fontSize: 28,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // EMAIL
                        TextField(
                          controller: emailController,

                          onChanged: (value) {
                            context.read<RegisterCubit>().emailChanged(value);
                          },

                          decoration: InputDecoration(
                            labelText: 'Email',

                            errorText: state.email.displayError != null
                                ? 'Email tidak valid'
                                : null,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD
                        TextField(
                          controller: passwordController,

                          obscureText: true,

                          onChanged: (value) {
                            context.read<RegisterCubit>().passwordChanged(
                              value,
                            );
                          },

                          decoration: InputDecoration(
                            labelText: 'Password',

                            errorText: state.password.displayError != null
                                ? 'Password minimal 6 karakter'
                                : null,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,

                          height: 50,

                          child: ElevatedButton(
                            onPressed:
                                !state.isValid ||
                                    state.status ==
                                        FormzSubmissionStatus.inProgress
                                ? null
                                : () {
                                    context.read<RegisterCubit>().register();
                                  },

                            child:
                                state.status == FormzSubmissionStatus.inProgress
                                ? const CircularProgressIndicator()
                                : const Text('Register'),
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