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

 void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,

        status: FormzSubmissionStatus.initial,

        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> register() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      print('REGISTER DIMULAI');

      await authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      await authenticationRepository.signOut();

      await userRepository.saveUser(email: state.email.value);

      print('REGISTER BERHASIL');

      emit(state.copyWith(status: FormzSubmissionStatus.success));

      emit(state.copyWith(status: FormzSubmissionStatus.initial));
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