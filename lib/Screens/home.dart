import 'package:connect/Screens/Around.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/Services/autocomplete.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connect/Models/place.dart';
import 'package:connect/Services/nearby.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Position currentLocation;
  List<PlaceDetail> places;
  double w,h;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PanelController _pc = new PanelController();
  int selectedPlace = 0;
  bool panelOpen = false;
  String uid;
  Auth auth = new Auth();
  String checkName, query = "";
  final TextEditingController _typeAheadController = TextEditingController();
  bool loading = true, virtual = false;

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
    String user = prefs.getString('uid');
    setState(() {
      uid = user;
    });
    await locateme();
  }

  nearby(double lat, double lng) async {
    List<PlaceDetail> temp = await getNearbyPlaces(lat, lng, 1000);
    setState(() {
      places = temp;
    });
    for (int i = 0; i < places.length; i++) {
      var markerIdVal = markers.length + 1;
      String mar = markerIdVal.toString();
      final MarkerId markerId = MarkerId(mar);
      LatLng latLng = new LatLng(places[i].lat, places[i].lng);
      final Marker marker = Marker(
        markerId: markerId, 
        position: latLng,
        onTap: () => {
          print(places[i])
        }
      );
      setState(() {
        markers[markerId] = marker;
      });
    }
    setState(() {
      loading = false;
    });
  }

  locateme() async {
    setState(() {
      query = "";
      virtual = false;
    });
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentLocation = pos;
    });
    if(mapController != null)
      await moveCamera(pos.latitude, pos.longitude);
    await nearby(currentLocation.latitude, currentLocation.longitude);
  }

  changePlace(String placeId) async {
    _typeAheadController.clear();
    setState(() {
      query = "";
      virtual = true;
    });
    Place place = await getPlaceDetailFromId(placeId);
    await moveCamera(place.lat, place.lng);
    await nearby(place.lat, place.lng);
  }

  moveCamera(double lat, double lng) async {
    setState(() {
      loading = true;
    });
    CameraPosition _kLake = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    places = null;
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        controller: _pc,
        body: currentLocation !=null ? Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
              target: LatLng(
                currentLocation.latitude,
                currentLocation.longitude),
                zoom: 15
              ),
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values)
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 0.05 * h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for a location",
                            hintStyle: GoogleFonts.ptSans(color: Colors.grey, fontSize: 22)
                          ),
                          controller: this._typeAheadController,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.gps_fixed), 
                        onPressed: () => {
                          locateme()
                        }
                      )
                    ],
                  )
                ),
              ),
            ),
            query.length > 0 ? Container(
              height: 0.3 * h,
              margin: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 0.15 * h),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: FutureBuilder(
                  future: fetchSuggestions(query),
                  builder: (context, snapshot) => snapshot.hasData ? ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title:
                            Text((snapshot.data[index] as Suggestion).description),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          changePlace(snapshot.data[index].placeId);
                        },
                      ),
                      itemCount: snapshot.data.length,
                    )
                  : SpinKitDoubleBounce(
                    color: cred,
                    size: 30.0,
                  ),
                )
              )
            )  : Container(),
          ],
        ) : SpinKitDoubleBounce(
          color: cred,
          size: 30.0,
        ),
        panel: panelOpen ? Column(
          children: [
            AppBar(
              title: Text("Check-In",
                style: GoogleFonts.ptSans(
                  fontSize: 20,
                  color: Colors.black
                )
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 0.05 * h,
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.black,
                onPressed: () => {
                  setState(() {
                    panelOpen = false;
                  }),
                  _pc.close(),
                },
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: w,
                  height: 0.25 * h,
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: FittedBox(
                      child: Image.network(places[selectedPlace].photoref),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.1 * w, bottom: 10),
                      child: Text(places[selectedPlace].name, 
                      style: GoogleFonts.ptSans(
                        fontSize: 20,
                        color: Colors.white
                      )
                    )
                  )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.1 * w),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      color: cred,
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: cred,
                              title: Text("Check In as",
                                style: GoogleFonts.ptSans(
                                  color: Colors.white
                                ),
                              ),
                              content: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                                  ),
                                ),
                                onChanged: (value) => {
                                  setState(() {
                                    checkName = value;
                                  })
                                },
                              ),
                              actions: [
                                RaisedButton(
                                  onPressed: () => {
                                    if(checkName != null) {
                                      auth.checkIn(uid, places[selectedPlace].name, checkName, virtual, places[selectedPlace].vincinity),
                                      Navigator.pop(context),
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Around(location: places[selectedPlace].name)))
                                    } else {
                                      Toast.show("Name cannot be empty", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM)
                                    }
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  child: Text("Check In",
                                    style: GoogleFonts.ptSans(
                                      color: cred,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        )
                      },
                      child: Text("Check In",
                        style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  )
                )
              ],
            ),
            SizedBox(
              height: 0.02 * h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 32),
                Text('28 Users checked in in last 2 hours', style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
            SizedBox(
              height: 0.02 * h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('In the spotlight', 
                  style: TextStyle(
                    fontSize: 0.05 * w,
                    color: const Color(0xff4f4f4f)
                  )
                ),
                SizedBox(
                  width: 0.1 * w,
                ),
                Text("M", style: GoogleFonts.ptSans(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 0.05 * w
                )),
                Text("/", style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 0.05 * w
                )),
                Text("F ", style: GoogleFonts.ptSans(
                  color: cred,
                  fontWeight: FontWeight.bold,
                  fontSize: 0.05 * w
                )),
                Text("Ratio: ", style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 0.05 * w
                )),
                Text("40%", style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  color: cred,
                  fontSize: 0.05 * w
                )),
              ],
            ),
            SizedBox(
              height: 0.02 * h,
            ),
            Text(places[selectedPlace].vincinity)
          ],
        ) : Center(
          child: Text("Please select a nearby place first"),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        minHeight: 0.25 * h,
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
            !loading ? Container(
              padding: EdgeInsets.symmetric(horizontal: 0.05 * w),
              height: 0.15 * h,
              child: ListView.builder(
                itemCount: places.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {
                      setState(() {
                        selectedPlace = index;
                        panelOpen = true;
                      }),
                      _pc.open()
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 0.4 * w,
                          height: 0.15 * h,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FittedBox(
                              child: Image.network(places[index].photoref),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(places[index].name, 
                            style: GoogleFonts.ptSans(
                              color: Colors.white
                            )
                          )
                        )
                      ],
                    )
                  );
                }
              )
            ) : SpinKitDoubleBounce(
              color: cred,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}