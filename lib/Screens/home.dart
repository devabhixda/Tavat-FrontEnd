import 'dart:async';
import 'dart:convert';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connect/Models/place.dart';
import 'package:connect/Services/nearby.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {

  int selected = 2;
  Position currentLocation;
  List<PlaceDetail> places;
  double w,h;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  initState() {
    super.initState();
    setLogin();
  }

  setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('login');
    if(login == null) {
      prefs.setBool('login', true);
    }
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position position) async {
        setState(() {
          currentLocation = position;
        });
        places = await getNearbyPlaces(position.latitude, position.longitude, 1000).then(
          (List<PlaceDetail> curr) {
            print(curr.length);
            for (int i = 0; i < curr.length; i++) {
              var markerIdVal = markers.length + 1;
              String mar = markerIdVal.toString();
              final MarkerId markerId = MarkerId(mar);
              LatLng latLng = new LatLng(curr[i].lat, curr[i].lng);
              final Marker marker = Marker(
                markerId: markerId, 
                position: latLng,
                onTap: () => {
                  print(curr[i])
                }
              );
              setState(() {
                markers[markerId] = marker;
              });
            }
          }
        );
      }).catchError((e) {
        print(e);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        body: currentLocation !=null ? GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation.latitude,
            currentLocation.longitude),
            zoom: 15
          ),
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values)
        ) : SpinKitDoubleBounce(
          color: cred,
          size: 30.0,
        ),
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        minHeight: 0.2 * h,
        collapsed: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(0.02 * h),
              child: Text("Check-In Nearby",
                style: GoogleFonts.ptSans(
                  fontSize: 20
                )
              )
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: cred,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: selected,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: ""
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }
}