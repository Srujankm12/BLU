
import 'package:blu/features/auth/bloc/auth_bloc.dart';
import 'package:blu/features/auth/bloc/auth_state.dart';
import 'package:blu/features/auth/widgets/button.dart';
import 'package:blu/features/auth/widgets/text_field.dart';
import 'package:blu/features/home/bloc/homepage_bloc.dart';
import 'package:blu/features/home/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => HomepageBloc(),
              child:const HomePage(),
            );
          }));
        }
        if (state is AuthErrorState) {}
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      //app name
                      Center(
                        child: Text(
                          'Blutooth Connect ',
                          style: GoogleFonts.nunito(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                  
                      //Icon
                     Lottie.asset('assests/Animation - 1726912958469.json'),
                  
                      const SizedBox(
                        height: 80,
                      ),
                  
                      //username
                      MyTextField(
                        controller: userController,
                        hintText: 'Username',
                        obscureText: false,
                      
                      ),
                  
                      const SizedBox(
                        height: 45,
                      ),
                  
                      //password
                      MyTextField(
                        
                        controller: passwordController,
                        hintText: 'password',
                        obscureText: true,
                      ),
                  
                      //button for login
                      const SizedBox(
                        height: 50,
                      ),
                  
                      //  MyButton(),
                  
                      MyButton(
                          name: state is AuthLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginButtonClicked(
                                    username: userController.text,
                                    password: passwordController.text));
                          })
                    ],
                  
                    //login button
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
