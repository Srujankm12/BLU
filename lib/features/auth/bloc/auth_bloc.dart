import 'dart:convert';
import 'package:blu/features/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginButtonClicked>((event, emit) async {
      try {
        emit(AuthLoadingState());

        // Validate username and password
        if (event.username.isEmpty) {
          emit(AuthErrorState(error: "Username cannot be empty"));
          return;
        }
        if (event.password.isEmpty) {
          emit(AuthErrorState(error: "Password cannot be empty"));
          return;
        }

        // Attempt login
        var jsonResponse = await http.post(
          Uri.parse('https://go-fingerprint.onrender.com/users/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "user_name": event.username,
            "password": event.password,
          }),
        );

        // Handle response
        if (jsonResponse.statusCode == 200) {
          var response = jsonDecode(jsonResponse.body);
          var box = await Hive.openBox("authtoken");
          box.put('token', response['data']);
          var userId = JwtDecoder.decode(response['data'])['id'];
          box.put('user_id', userId);
          box.close();

          emit(AuthSuccessState());
        } else if (jsonResponse.statusCode == 401) {
          emit(AuthErrorState(error: "Invalid username or password"));
        } else if (jsonResponse.statusCode == 500) {
          emit(AuthErrorState(error: "Server error, please try again later"));
        } else {
          emit(AuthErrorState(error: "Unexpected error: Enter valid credentials"));
        }

      } catch (e) {
        emit(AuthErrorState(error: "An unexpected error occurred: Check your internet connection"));
      }
    });
  }
}
