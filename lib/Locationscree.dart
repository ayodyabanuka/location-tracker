import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'dart:convert';
import 'dart:convert' show jsonDecode;

class locationtracker extends StatefulWidget {
  locationtracker({Key? key}) : super(key: key);

  @override
  State<locationtracker> createState() => _locationtrackerState();
}

class _locationtrackerState extends State<locationtracker> {
  Timer? timer;
  String Api_Url =
      'http://backenddomain.sindhizgroup.com.au/public/api/addlocation';

  @override
  void initState() {
    Permission.locationWhenInUse.isGranted;
    timer =
        Timer.periodic(Duration(seconds: 3), (Timer t) => getCurrentLocation());
    super.initState();
  }

  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    Object add = {
      'current_location': position,
    };
    String Final = jsonEncode(add);
    final Uri url = Uri.parse(Api_Url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'supportsCredentials': 'true',
          'allowedOrigins': '*',
          'allowedOriginsPatterns': '',
          'allowedHeaders': '*',
          'allowedMethods': '*',
          'connection': 'keep-alive',
        },
        body: Final);

    // print(lastPosition);
    // setState(() {
    //   locationMessage = "{$position}";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 46,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'User Current Location',
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Text(locationMessage),
            // FlatButton(
            //   onPressed: () {

            //   },
            //   child: const Text(
            //     "Get location",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   color: Colors.blue,
            // )
          ],
        ),
      ),
    );
  }
}
