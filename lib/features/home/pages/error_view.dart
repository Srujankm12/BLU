import 'package:blu/features/home/bloc/homepage_event.dart';
import 'package:blu/features/home/pages/homepage.dart';
import 'package:flutter/material.dart';
import '../bloc/homepage_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $error', style:
          const TextStyle(
            color: Colors.black ,
            fontSize: 18,
            fontWeight:FontWeight.bold,
            )
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            ),
            onPressed: () {
            context.read<HomepageBloc>().add(HomepageButtonClicked()); 
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
