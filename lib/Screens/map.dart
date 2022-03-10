import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/config.dart';
import 'login.dart';

class DisplayMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  const DisplayMap({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<DisplayMap> createState() => DisplayMapState();
}

class DisplayMapState extends State<DisplayMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14.4746,
    );
    final Set<Marker> markers = {};

    markers.add(Marker(
      //add first marker
      markerId: const MarkerId("PickUp-Center"),
      position: LatLng(widget.latitude, widget.longitude), //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Pick up Center',
        snippet: 'Pick up Center',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Location",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: GoogleMap(
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _resetPoint(_kGooglePlex),
        child: const Icon(Icons.location_pin),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _resetPoint(_kGooglePlex) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
