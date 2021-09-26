part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignIn extends AuthEvent {
  final String username;
  final String password;

  SignIn(this.username, this.password);
}

class CheckToken extends AuthEvent {
}
class SignOut extends AuthEvent {}
