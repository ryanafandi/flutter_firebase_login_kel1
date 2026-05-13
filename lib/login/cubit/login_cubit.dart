import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/email.dart';
import '../models/password.dart';

import '../../authentication/repository/authentication_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository})
    : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,

        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,

        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logIn() async {
    if (!state.isValid) {
      emit(state.copyWith(errorMessage: 'Form tidak valid'));

      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await authenticationRepository.signIn(
        email: state.email.value,

        password: state.password.value,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,

          errorMessage: e.toString(),
        ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }
  }
}