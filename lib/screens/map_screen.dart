import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:native_func_app/models/place.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import '../models/place.dart';
import '../helpers/location_helpers.dart';

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
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 16.0,
            //onTap: widget.isSelecting ? _selectLocation: null,
            // onTap: widget.isSelecting
            //     ? _selectLocation
            //     : (TapPosition tapPosition, LatLng position) {},
            onTap: widget.isSelecting ? _selectLocation : null),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/dhe/ckyvmmys8003c15l4crl1repj/tiles/256/{z}/{x}/{y}@2x?access_token=$MAPBOX_API_KEY",
              additionalOptions: {
                'accessToken': '$MAPBOX_API_KEY',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          MarkerLayerOptions(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point: _pickedLocation ??
                          LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          ),
                      builder: (ctx) => Container(
                        child: Icon(Icons.location_on),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
