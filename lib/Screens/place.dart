import 'package:connect/Screens/around.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class place extends StatefulWidget {
  @override
  _placeState createState() => _placeState();
}
class _placeState extends State<place> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(-100, -200.8),
            child: SvgPicture.string(
              _svg_u2p3dc,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.1 * h,
              ),
              Center(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Container(
                    width: 0.8 * w,
                    height: 0.3 * h,
                  ),
                )
              ),
            ],
          ),
          SlidingUpPanel(
            minHeight: 0.55 * h,
            maxHeight: 0.9 * h,
            panel: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.15 * w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.05 * h,
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
                    Text('In the spotlight', 
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xff4f4f4f),
                        fontWeight: FontWeight.w700,
                      )
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text('This time’s line-up is all about sensational music. Popular international DJ, Marc Roberts will be in the house to steward the party’s music scene.'),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Container(
                      height: 0.15 * h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Container(
                              width: 0.3 * w,
                              height: 0.1 * h,
                            ),
                          );
                        }
                      ),
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Text('User Reviews', 
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xff4f4f4f),
                        fontWeight: FontWeight.w700,
                      )
                    ),
                    SizedBox(
                      height: 0.02 * h,
                    ),
                    Container(
                      height: 0.3 * h,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Joshua"),
                                  Text("Just imagine how many people still come back here everyday.")
                                ],
                              ),
                            )
                          );
                        }
                      ),
                    )
                  ],
                ),
              )
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            )
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.1 * h)),
                child: Container(
                  height: 0.08 * h,
                  width: 0.8 * w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => around()))
                        },
                      ),
                      Container(width: 1, height: 0.04 * h, color: Colors.black),
                      Icon(Icons.home),
                      Container(width: 1, height: 0.04 * h, color: Colors.black),
                      Icon(Icons.message, color: Colors.red)
                    ],
                  ),
                )
              )
            ),
          ),
        ]
      )
    );
  }
}
const String _svg_u2p3dc =
    '<svg viewBox="-192.9 -621.8 560.0 1227.6" ><path transform="translate(-1455.0, 78.0)" d="M 1283.42236328125 527.830078125 C 1285.230102539063 405.8142395019531 1225.114868164063 352.5777282714844 1463.632202148438 260.9307250976563 C 1532.3251953125 234.5363922119141 2124.227294921875 -49.61784362792969 1977.826904296875 -452.0097045898438 C 1772.20849609375 -1017.166259765625 1264.445556640625 -438.6750793457031 1264.445556640625 -438.6750793457031 C 1264.445556640625 -438.6750793457031 1267.156982421875 -232.1470336914063 1264.445556640625 -231.2432250976563 C 1261.734130859375 -230.3394165039063 1260.830322265625 -14.46113395690918 1264.445556640625 1.807641863822937 C 1268.060791015625 18.07641792297363 1283.42236328125 527.830078125 1283.42236328125 527.830078125 Z" fill="#f61b39" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';