import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../login/models/email.dart';
import '../../login/models/password.dart';

class RegisterState extends Equatable {
  final Email email;
  final Password password;

  final FormzSubmissionStatus status;

  final bool isValid;

  final String errorMessage;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),

    this.status = FormzSubmissionStatus.initial,

    this.isValid = false,

    this.errorMessage = '',
  });

  RegisterState copyWith({
    Email? email,
    Password? password,

    FormzSubmissionStatus? status,

    bool? isValid,

    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,

      password: password ?? this.password,

      status: status ?? this.status,

      isValid: isValid ?? this.isValid,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status, isValid, errorMessage];
}