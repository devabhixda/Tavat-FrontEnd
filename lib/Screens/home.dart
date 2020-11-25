import 'dart:async';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connect/Models/place.dart';
import 'package:connect/Services/nearby.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {

  int selected = 2;
  Position position = new Position(latitude: 0, longitude: 0);
  List<PlaceDetail> places;
  double w,h;

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
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(await getNearbyPlaces(position.latitude, position.longitude, 10));
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: SlidingUpPanel(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude)
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
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

  void _onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }
}