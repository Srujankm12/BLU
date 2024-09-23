import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class BluetoothLoadingState extends HomepageState {}

class BluetoothSuccessState extends HomepageState {
  final List<BluetoothDevice> devices;
  BluetoothSuccessState(this.devices);
}

class BluetoothConnectedState extends HomepageState {
  final BluetoothConnection connection;
  BluetoothConnectedState(this.connection, String? userId);

 
}

class BluetoothErrorState extends HomepageState {
  final String error;
  BluetoothErrorState({required this.error});
}

class BluetoothDataReceivedState extends HomepageState {
  final String data;
  BluetoothDataReceivedState(this.data);
}
class DataSentSuccessState extends HomepageState {
  final String message;
  DataSentSuccessState({required this.message});
}

