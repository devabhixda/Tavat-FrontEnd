import 'package:connect/Screens/chat.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class around extends StatefulWidget {
  @override
  _aroundState createState() => _aroundState();
}
class _aroundState extends State<around> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgrey,
      resizeToAvoidBottomPadding: false,
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
          Align(
            alignment: Alignment.center,
            child: Card(
              child: Container(
                height: 0.8 * h,
                width: 0.8 * w,
                child: Column(
                  children: [
                    Container(
                      height: 0.1 * h,
                      width: 0.7 * w,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Search",
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () => {
                                print("Pressed")
                              },
                            )
                          ),
                      ),
                    ),
                    Container(
                      height: 0.7 * h,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => chat()));
                              },
                              leading: CircleAvatar(),
                              title: Text("Person"),
                            );
                          },
                      ),
                    )
                  ],
                )
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
            )
          )
        ]
      )
    );
  }
}
const String _svg_u2p3dc =
    '<svg viewBox="-192.9 -621.8 560.0 1227.6" ><path transform="translate(-1455.0, 78.0)" d="M 1283.42236328125 527.830078125 C 1285.230102539063 405.8142395019531 1225.114868164063 352.5777282714844 1463.632202148438 260.9307250976563 C 1532.3251953125 234.5363922119141 2124.227294921875 -49.61784362792969 1977.826904296875 -452.0097045898438 C 1772.20849609375 -1017.166259765625 1264.445556640625 -438.6750793457031 1264.445556640625 -438.6750793457031 C 1264.445556640625 -438.6750793457031 1267.156982421875 -232.1470336914063 1264.445556640625 -231.2432250976563 C 1261.734130859375 -230.3394165039063 1260.830322265625 -14.46113395690918 1264.445556640625 1.807641863822937 C 1268.060791015625 18.07641792297363 1283.42236328125 527.830078125 1283.42236328125 527.830078125 Z" fill="#f61b39" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';