import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:location/location.dart';

const String apiKey = "AIzaSyD2s1d-NbTMPxsKDems87TGyTLaJu3223g";

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
  final TextEditingController _searchController = TextEditingController();

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
              markerId: const MarkerId("current_location"),
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

  void _onPlaceSelected(dynamic prediction) {
    if (prediction["lat"] == null || prediction["lng"] == null) {
      return;
    }

    double lat = double.parse(prediction["lat"]);
    double lng = double.parse(prediction["lng"]);
    LatLng searchedLocation = LatLng(lat, lng);

    setState(() {
      _selectedLocation = searchedLocation;
      markers.removeWhere(
          (marker) => marker.markerId.value == "searched_location");
      markers.add(
        Marker(
          markerId: const MarkerId("searched_location"),
          position: searchedLocation,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });

    _controller.animateCamera(
      CameraUpdate.newLatLngZoom(searchedLocation, 15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? const LatLng(17.385044, 78.486671),
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
                    markerId: const MarkerId("selected_location"),
                    position: latLng,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                );
              });
            },
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                googleAPIKey: apiKey,
                inputDecoration: const InputDecoration(
                  hintText: "Search Location",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                debounceTime: 400,
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (prediction) {
                  _onPlaceSelected(prediction);
                },
                itemClick: (prediction) {
                  _searchController.text = prediction.description ?? "";
                  _onPlaceSelected(prediction);
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
              child: const Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}
