
import 'package:blu/features/home/bloc/homepage_bloc.dart';
import 'package:blu/features/home/bloc/homepage_event.dart';
import 'package:blu/features/home/bloc/homepage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'device_list_view.dart';
import 'connected_view.dart';
import 'error_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController userIdController;
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    _retrieveUserId();
  }

  Future<void> _retrieveUserId() async {
    var box = await Hive.openBox("authtoken");
    var userId = box.get('user_id', defaultValue: '');
    userIdController.text = userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'BT Connect',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => HomepageBloc(),
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state is BluetoothLoadingState) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  size: 40,
                  color: Colors.black,
                ),
              );
            } else if (state is BluetoothErrorState) {
              return ErrorView(error: state.error);
            } else if (state is BluetoothSuccessState) {
              return DeviceListView(devices: state.devices);
            } else if (state is BluetoothConnectedState) {
              return ConnectedView(connection: state.connection, userIdController: userIdController, ssidController: ssidController, passwordController: passwordController);
            }
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => context.read<HomepageBloc>().add(HomepageButtonClicked()),
                child: const Text(
                  'Start Searching',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    userIdController.dispose();
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
