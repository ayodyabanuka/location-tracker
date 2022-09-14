import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/Providers/locationProvider.dart';
import 'package:location_tracker/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workmanager/workmanager.dart';

class locationtracker extends StatefulWidget {
  locationtracker({Key? key}) : super(key: key);

  @override
  State<locationtracker> createState() => _locationtrackerState();
}

class _locationtrackerState extends State<locationtracker> {
  // Timer? timer;

  @override
  void initState() {
    requestLocationPermission();
    timer = Timer.periodic(
        Duration(seconds: 11),
        (Timer t) => Workmanager().registerOneOffTask(
              backrun,
              backrun,
              initialDelay: Duration(seconds: 10),
            ));
  }

  Future<void> requestLocationPermission() async {
    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WELCOME')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('WELCOME')),
          // ElevatedButton(onPressed: () {}, child: Text('Start'))
        ],
      ),
    );
  }
}
