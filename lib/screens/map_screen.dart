import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:native_func_app/models/place.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  //const MapScreen({ Key? key }) : super(key: key);
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.421, longitude: -122.084),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(TapPosition tapPosition, LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          //onTap: widget.isSelecting ? _selectLocation: null,
          onTap: widget.isSelecting
              ? _selectLocation
              : (TapPosition tapPosition, LatLng position) {},
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/dhe/ckwd8qofr09gd14oq5d8djor9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGhlIiwiYSI6ImNrdnFybGw4ZzI1cWgycm91MXBpcW9oN3kifQ.fzK2_BFZrGU_vMpwTuU2Kg",
              /*subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },*/
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiZGhlIiwiYSI6ImNrdnFybGw4ZzI1cWgycm91MXBpcW9oN3kifQ.fzK2_BFZrGU_vMpwTuU2Kg',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          MarkerLayerOptions(
            markers: _pickedLocation == null
                ? []
                : [
                    Marker(
                      point: _pickedLocation,
                      builder: (ctx) => Container(
                        child: FlutterLogo(),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
