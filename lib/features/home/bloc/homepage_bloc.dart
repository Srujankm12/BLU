import 'dart:convert';
import 'dart:typed_data';
import 'package:blu/features/home/bloc/homepage_event.dart';
import 'package:blu/features/home/bloc/homepage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  BluetoothConnection? _connection;

  HomepageBloc() : super(HomepageInitial()) {
    on<HomepageButtonClicked>(_onHomepageButtonClicked);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<SendDataEvent>(_onSendData);
    on<BluetoothDataReceivedEvent>(_onBluetoothDataReceived);
  }

  Future<void> _onHomepageButtonClicked(HomepageButtonClicked event, Emitter<HomepageState> emit) async {
    emit(BluetoothLoadingState());
    try {
      await _requestPermissions();
      final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      emit(BluetoothSuccessState(devices));
    } catch (e) {
      emit(BluetoothErrorState(error: e.toString()));
    }
  }

  Future<void> _onConnectToDevice(ConnectToDeviceEvent event, Emitter<HomepageState> emit) async {
    emit(BluetoothLoadingState());
    try {
      _connection = await BluetoothConnection.toAddress(event.device.address);
      final box = await Hive.openBox("authtoken");
      final userId = box.get('user_id');
      box.close();
      emit(BluetoothConnectedState(_connection!, userId));
      _listenForData();
    } catch (e) {
      emit(BluetoothErrorState(error: 'Failed to connect to device.'));
    }
  }

  Future<void> _onSendData(SendDataEvent event, Emitter<HomepageState> emit) async {
    if (_connection != null && _connection!.isConnected) {
      final message = jsonEncode({
        'user_id': event.userId,
        'ssid': event.ssid,
        'password': event.password,
      }) + '*';
      _connection!.output.add(Uint8List.fromList(message.codeUnits));
      await _connection!.output.allSent;
      emit(DataSentSuccessState(message: 'Data sent successfully!'));
    } else {
      emit(BluetoothErrorState(error: 'Not connected to any device.'));
    }
  }

  void _onBluetoothDataReceived(BluetoothDataReceivedEvent event, Emitter<HomepageState> emit) {
    print('Data received: ${event.data}');
  }

  void _listenForData() {
    _connection?.input?.listen(
      (Uint8List data) {
        final response = String.fromCharCodes(data);
        add(BluetoothDataReceivedEvent(response));
      },
      onError: (error) {
        emit(BluetoothErrorState(error: error.toString()));
        _disconnect();
      },
    );
  }

  Future<void> _requestPermissions() async {
    await Permission.bluetooth.request();
    await Permission.location.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  void _disconnect() {
    _connection?.close();
    _connection = null;
  }
}
