import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class locationProvider with ChangeNotifier {
  AddLocation(latitude, longtitude) async {
    //todo:
    return await http.post(
        Uri.parse(
            'http://backenddomain.sindhizgroup.com.au/public/api/addlocation'),
        headers: _setHeaders(),
        body: _body(latitude, longtitude));
  }

  _setHeaders() => {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'supportsCredentials': 'true',
        'allowedOrigins': '*',
        'allowedOriginsPatterns': '',
        'allowedHeaders': '*',
        'allowedMethods': '*',
        'connection': 'keep-alive',
      };
  _body(latitude, longtitude) => {
        'latitude': latitude.toString(),
        'longitude': longtitude.toString(),
      };
}
