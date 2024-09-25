import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';

class DeviceListView extends StatefulWidget {
  final List<BluetoothDevice> devices;

  const DeviceListView({Key? key, required this.devices}) : super(key: key);

  @override
  _DeviceListViewState createState() => _DeviceListViewState();
}

class _DeviceListViewState extends State<DeviceListView> {
  BluetoothDevice? selectedDevice;
  BluetoothState? bluetoothState;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  Future<void> _checkBluetoothState() async {
    bluetoothState = await FlutterBluetoothSerial.instance.state;
    setState(() {});
    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      setState(() {
        bluetoothState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          'Select Required Bluetooth Device',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Lottie.asset('assests/Animation - 1726902764458.json', height: 200),
        const SizedBox(height: 0),
        Text(
          bluetoothState == BluetoothState.STATE_ON ? "Bluetooth is ON" : "Bluetooth is OFF",
          style: const TextStyle(
            color: Colors.black, 
            fontSize: 18, 
            fontWeight: FontWeight.bold
            ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<BluetoothDevice>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          hint: const Text('Select Device'),
          value: selectedDevice,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          isExpanded: true,
          onChanged: bluetoothState == BluetoothState.STATE_ON
              ? (BluetoothDevice? value) {
                  setState(() {
                    selectedDevice = value;
                  });
                }
              : null, // Disable if Bluetooth is OFF
          items: widget.devices.map((device) {
            return DropdownMenuItem(
              value: device,
              child: Text(device.name ?? device.address),
            );
          }).toList(),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: selectedDevice != null && bluetoothState == BluetoothState.STATE_ON
              ? () {
                  context.read<HomepageBloc>().add(ConnectToDeviceEvent(selectedDevice!));
                }
              : null, 
          child: const Text(
            'Connect',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
