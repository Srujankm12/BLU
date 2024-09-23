import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText,


  });

  @override
  Widget build(BuildContext context) {
    return   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:  TextField(              
                  cursorColor: Colors.black,
                   controller: controller,
                   obscureText: obscureText,                  
                   decoration: InputDecoration(       
                    enabledBorder: const OutlineInputBorder(                                          
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    focusedBorder: const OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black), 
                     borderRadius: BorderRadius.all(Radius.circular(12)), 
                    ),              
                    hoverColor: Colors.white,
                    fillColor:Colors.white,
                    filled: true,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    )
                   ),
                ),
              );
  }
}