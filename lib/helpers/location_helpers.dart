import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

const MAPBOX_API_KEY =
    'pk.eyJ1IjoiZGhlIiwiYSI6ImNreXU4cGl1dDFrbzMyb3A2a3ZxdWZtanYifQ.1ykG7nY2Zqh2-ldiOXGfTQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
    //return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14.25,0,60/300x300?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        await 'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$MAPBOX_API_KEY');
    final response = await http.get(url);
    print(json.decode(response.body));
    //the return statement below is for Google Maps Geocoding
    //return json.decode(response.body)['results'][0]['formatted_address'];
    //the return statement is for MapboxApi
    //return json.decode(response.body)['features'][0]['address'];
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
