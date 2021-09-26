part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class Initial extends AuthState {}

class Loading extends AuthState {}

class Authenticated extends AuthState {
  Authenticated(this.token);
  final String token;
}

class Unauthenticated extends AuthState {}
