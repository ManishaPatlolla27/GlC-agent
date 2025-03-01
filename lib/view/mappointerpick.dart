import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController _controller;
  final Location _location = Location();
  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  Set<Marker> markers = {};
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      final locationData = await _location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        _currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        _selectedLocation = _currentLocation;

        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId("current_location"),
              position: _currentLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );
        });

        _controller.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation!, 15.0),
        );
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? LatLng(17.385044, 78.486671),
              zoom: 15.0,
            ),
            onMapCreated: (controller) {
              _controller = controller;
            },
            myLocationEnabled: true,
            markers: markers,
            onTap: (LatLng latLng) {
              setState(() {
                _selectedLocation = latLng;
                markers.removeWhere(
                    (marker) => marker.markerId.value == "selected_location");
                markers.add(
                  Marker(
                    markerId: MarkerId("selected_location"),
                    position: latLng,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                );
              });
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
              child: Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}
