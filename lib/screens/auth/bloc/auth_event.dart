part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CreateAccount extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String mobileNumber;

  CreateAccount({
    required this.email,
    required this.password,
    required this.name,
    required this.mobileNumber
  });
}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password
  });
}

class orderhis extends AuthEvent {
  final String uid;
  final String orderid;

  orderhis({
    required this.uid,
    required this.orderid
  });
}

class SignInWithGoogle extends AuthEvent {}

class SignInWithFacebook extends AuthEvent {}

class SignInWithGithub extends AuthEvent {}