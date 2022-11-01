import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'moveable.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  final double width = 100.0;
  final double height = 100.0;

  late Offset position;

  @override
  void initState() {
    super.initState();

    position = Offset(0.0, height - 20);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sample App'),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Moveable(
              initPosition: const Offset(0.0, 0.0),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    child: const Center(
                      child: Text('Frosted'),
                    ),
                  ),
                ),
              ),
            ),
            Moveable(
              initPosition: const Offset(0, 200),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.8)),
                child: const Center(
                  child: Text('Basic'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
