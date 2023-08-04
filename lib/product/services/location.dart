import 'dart:convert';

import 'package:adflaunt/product/models/profile/ipdata.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<LatLng> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission()
        .onError((error, stackTrace) => throw Exception(error.toString()));
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return await getLocationFromIp();
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 5));
        return LatLng(position.latitude, position.longitude);
      } catch (e) {
        return await getLocationFromIp();
      }
    }
  }

  Future<LatLng> getLocationFromIp() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final model = Ipdata.fromJson(json);
        return LatLng(model.lat!, model.lon!);
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw e;
    }
  }
}
