
import 'package:blu/features/home/bloc/homepage_state.dart';
import 'package:blu/features/home/pages/homepage.dart';
import 'package:blu/features/home/widgets/textfield.dart';
import 'package:blu/features/success/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectedView extends StatelessWidget {
  final BluetoothConnection connection;
  final TextEditingController userIdController;
  final TextEditingController ssidController;
  final TextEditingController passwordController;

  const ConnectedView({
    Key? key,
    required this.connection,
    required this.userIdController,
    required this.ssidController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Connected to Bluetooth Device',
              style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 30),
            HomeTextField(controller: userIdController, hintText: "UserId", obscureText: false),
            const SizedBox(height: 40),
            HomeTextField(controller: ssidController, hintText: "SSID", obscureText: false),
            const SizedBox(height: 40),
            HomeTextField(controller: passwordController, hintText: "Password", obscureText: true),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 6,
                padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                context.read<HomepageBloc>().add(SendDataEvent(
                  userIdController.text,
                  ssidController.text,
                  passwordController.text,
                ));

                context.read<HomepageBloc>().stream.listen((state) {
                  if (state is DataSentSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(message: state.message),
                      ),
                    );
                  } else if (state is BluetoothErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.error}'),
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }
                });

                ssidController.clear();
                passwordController.clear();
              },
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
