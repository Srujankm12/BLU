

import 'package:flutter/material.dart';

@immutable
class AuthState {}

 class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState{}

 class AuthSuccessState extends AuthState{}

 class AuthErrorState extends AuthState{
  final String error;
  AuthErrorState({required this.error});
}
