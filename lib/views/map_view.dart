import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/models.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final latLng = scan.getLatLng();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: latLng,
      zoom: 17.5,
      tilt: 50,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(
        Marker(markerId: const MarkerId('geo-location'), position: latLng));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: latLng,
                      zoom: 17.5,
                      tilt: 50,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.location_searching))
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
