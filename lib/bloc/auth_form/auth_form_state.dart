part of 'auth_form_cubit.dart';

@immutable
class AuthFormState {
  final String? username;
  final String? password;
  final String? error;

  AuthFormState({
    required this.username,
    required this.password,
    this.error,
  });

  copyWith({
    String? username,
    String? password,
    String? error,
  }) =>
      AuthFormState(
        username: username ?? this.username,
        password: password ?? this.password,
        error: error ?? this.error,
      );
}
