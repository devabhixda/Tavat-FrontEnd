import 'dart:convert';

import 'package:connect/consts.dart';
import 'package:http/http.dart' as http;

class Place {
  double lat;
  double lng;

  Place({this.lat, this.lng
  });
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);
}

Future<List<Suggestion>> fetchSuggestions(String input) async {
  final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key';
  final response = await http.get(request);
  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    if (result['status'] == 'OK') {
      return result['predictions']
      .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
      .toList();
    }
    if (result['status'] == 'ZERO_RESULTS') {
      return [];
    }
    throw Exception(result['error_message']);
  } else {
    throw Exception('Failed to fetch suggestion');
  }
}

Future<Place> getPlaceDetailFromId(String placeId) async {
  final request = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
  var response = await http.get(request);
  if (response.statusCode == 200) {
    var res = json.decode(response.body)["result"];
    final place = Place();
    place.lat = res["geometry"]["location"]["lat"];
    place.lng = res["geometry"]["location"]["lng"];
    return place;
  } else {
    throw Exception('Failed to fetch suggestion');
  }
}