import 'package:blu/features/home/bloc/homepage_bloc.dart';
import 'package:blu/features/home/bloc/homepage_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessPage extends StatelessWidget {
  final String message;

  const SuccessPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Success'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.black),
            const SizedBox(height: 50),
            Text(
              message,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 10,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              
              onPressed: () {
                context.read<HomepageBloc>().add(HomepageButtonClicked());
              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
            
              child: const Text(
                'Start Searching Again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),

                ),
            ),
          ],
        ),
      ),
    );
  }
}
