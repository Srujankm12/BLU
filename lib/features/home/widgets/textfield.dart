import 'package:flutter/material.dart';

class HomeTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const HomeTextField({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:  TextField(                 
                  cursorColor: Colors.black,
                   controller: controller,
                   obscureText: obscureText,
                   decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    focusedBorder: const OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black),  
                     borderRadius: BorderRadius.all(Radius.circular(10)),
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