part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class AuthLoginButtonClicked extends AuthEvent{

  final String username;
  final String password;

  AuthLoginButtonClicked({required this.username,required this.password});
  
}
