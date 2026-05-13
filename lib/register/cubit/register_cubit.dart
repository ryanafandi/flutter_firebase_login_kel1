import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../authentication/repository/authentication_repository.dart';
import '../../user/repository/user_repository.dart';

import '../../login/models/email.dart';
import '../../login/models/password.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository = UserRepository();

  RegisterCubit({required this.authenticationRepository})
    : super(const RegisterState());

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,

        status: FormzSubmissionStatus.initial,

        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

