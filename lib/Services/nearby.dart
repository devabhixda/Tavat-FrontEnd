import 'package:connect/consts.dart';
import 'package:http/http.dart' as http;
import 'package:connect/Models/place.dart';
import 'dart:async';
import 'dart:convert';

Future<List<PlaceDetail>> getNearbyPlaces(double lat, double lng, double radius) async {
  List<PlaceDetail> places = [];
  for(String type in types) {
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat.toString()+","+lng.toString()+"&type="+type+"&radius="+radius.toString()+"&key="+key;
    var reponse = await http.get(url, headers: {"Accept": "application/json"});
    List data = json.decode(reponse.body)["results"];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"], f["icon"], f["rating"].toString(), f["geometry"]["location"]["lat"], f["geometry"]["location"]["lng"])));
  }
  return places;
}