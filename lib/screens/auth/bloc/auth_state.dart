part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class LoginSucess extends AuthState {}

class HistorySucess extends AuthState {}

class SignupSuccess extends AuthState {}

class AuthSuccess extends AuthState {}

class Failure extends AuthState {
  final String message;
  Failure({
    required this.message
  });
}