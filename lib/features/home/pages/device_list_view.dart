// features/home/pages/device_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';

class DeviceListView extends StatelessWidget {
  final List<BluetoothDevice> devices;

  const DeviceListView({Key? key, required this.devices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BluetoothDevice? selectedDevice;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
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
            const Text(
              "Ensure Bluetooth is ON",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
              onChanged: (BluetoothDevice? value) {
                setState(() {
                  selectedDevice = value;
                });
              },
              items: devices.map((device) {
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
              onPressed: () {
                if (selectedDevice != null) {
                  context.read<HomepageBloc>().add(ConnectToDeviceEvent(selectedDevice!));
                }
              },
              child: const Text(
                'Connect',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
