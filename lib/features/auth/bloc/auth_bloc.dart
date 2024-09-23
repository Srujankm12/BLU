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
    on<AuthLoginButtonClicked>((event, emit) async{
      try{
        emit(AuthLoadingState());
        if(event.username.isEmpty || event.password.isEmpty){
          emit(AuthErrorState(error:"Enter username and password correctly"));
          return;
        }
       
        var jsonResponse = await http.post(
          Uri.parse('https://go-fingerprint.onrender.com/users/login'),
          body: jsonEncode({
              "user_name":event.username,
              "password":event.password,
          })
        );

        if(jsonResponse.statusCode==200){
          var response =jsonDecode(jsonResponse.body);
          print(response);
          print(response);
          var box = await Hive.openBox("authtoken");
          box.put('token', response['data']);
   
          var userId = JwtDecoder.decode(response['data'])['id'];
          box.put('user_id', userId);
          print(userId);
          box.close();  

    
         

          emit(AuthSuccessState());
        }
        emit(AuthErrorState(error: "failed to login"));

      }catch(e){
        emit(AuthErrorState(error: "exception"));

      }
    
    });
  }
}
