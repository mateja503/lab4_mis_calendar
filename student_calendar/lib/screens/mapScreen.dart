import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils.dart';

class MapScreen extends StatefulWidget {
  final Event event;

  const MapScreen({super.key, required this.event});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late Event _event;
  Position? _userPosition;
  List<LatLng> _routePoints = [];

  // API Key for Google Maps (Replace with your actual API key)
  final String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // Fetch the user's location as soon as the app opens
  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        // Handle the case where permissions are permanently denied
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userPosition = position;  // Save the user's position
      });

      // After getting the user's location, calculate the route
      if (_userPosition != null) {
        _getRoute(_userPosition!, _event.location);
      }
    } catch (e) {
      // Handle location fetch failure, e.g., permission denied
      print("Error fetching location: $e");
    }
  }

  // Fetch directions using Google Maps Directions API
  Future<void> _getRoute(Position userPosition, LatLng eventLocation) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${userPosition.latitude},${userPosition.longitude}&destination=${eventLocation.latitude},${eventLocation.longitude}&key=AIzaSyAYlArVfnDXVm5UDLTtPNLj0k31VLxfqhQ';
    print('Request URL: $url');
    print('User position: ${userPosition.latitude}, ${userPosition.longitude}');
    print('Event position: ${eventLocation.latitude}, ${eventLocation.longitude}');

    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Check if routes and legs are not empty
      if (data['routes'].isEmpty || data['routes'][0]['legs'].isEmpty) {
        print('No route data available.');
        return;
      }
      if (data['routes'] == null || data['routes'].isEmpty) {
        print('No routes found for the provided origin and destination.');
        return;
      }

      final route = data['routes'][0]['legs'][0]['steps'];

      if (route.isEmpty) {
        print('No steps available in the route.');
        return;
      }

      List<LatLng> points = [];
      for (var step in route) {
        final polylinePoints = step['polyline']['points'];
        points.addAll(_decodePolyline(polylinePoints));
      }

      setState(() {
        _routePoints = points; // Save the decoded polyline points
      });
    } else {
      print('Failed to load directions');
    }
  }


  // Decode polyline points to LatLng list
  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0;
    int len = polyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dLat = (result & 0x1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dLat;

      shift = 0;
      result = 0;

      do {
        b = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dLng = (result & 0x1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (_userPosition == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(_userPosition!.latitude, _userPosition!.longitude),
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('event'),
            position: _event.location,
            infoWindow: InfoWindow(
              title: _event.name,
              snippet: _event.startTime.toString(),
            ),
          ),
          Marker(
            markerId: MarkerId('user'),
            position: LatLng(_userPosition!.latitude, _userPosition!.longitude),
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: _routePoints,
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }
}
