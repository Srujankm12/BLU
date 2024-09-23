import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageEvent {}

class HomepageButtonClicked extends HomepageEvent {}

class BluetoothLoadingEvent extends HomepageEvent {}

class ConnectToDeviceEvent extends HomepageEvent {
  final BluetoothDevice device;
  ConnectToDeviceEvent(this.device);
}

class SendDataEvent extends HomepageEvent {
  final String userId;
  final String ssid;
  final String password;

  SendDataEvent(this.userId, this.ssid, this.password);
}

class BluetoothDataReceivedEvent extends HomepageEvent {
  final String data;
  BluetoothDataReceivedEvent(this.data);
}
