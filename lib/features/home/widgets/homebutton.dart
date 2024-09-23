import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Function()? onTap;
  final Widget name;

  const HomeButton({super.key, required this.onTap , required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width:120,
        //padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.black

        ),
        child:  Center(
          child: name,
        ),
      ),
    );
  }
}
