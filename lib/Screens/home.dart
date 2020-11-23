import 'package:connect/Screens/checkIn.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
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
  }
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgrey,
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(-49.7, -170.8),
            child: SvgPicture.string(
              _svg_ey059c,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.1 * h,
                ),
                GestureDetector(
                  child: Container(
                    width: 0.6 * w,
                    height: 0.6 * w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1a000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text('CHECK-IN', style: TextStyle(
                        fontSize: 32
                      ))
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => checkIn()))
                  },
                ),
                SizedBox(
                  height: 0.15 * h,
                ),
                Container(
                  width: 0.6 * w,
                  height: 0.6 * w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1a000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('LOOK', style: TextStyle(
                          fontSize: 32
                        )),
                        Text('AROUND', style: TextStyle(
                          fontSize: 32
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
const String _svg_ey059c = '<svg viewBox="-69.7 -170.8 56.2 598.7" ><path transform="translate(-1314.0, 0.0)" d="M 1283.42236328125 527.830078125 C 1285.230102539063 405.8142395019531 1333.132446289063 125.6307678222656 1551.856567382813 198.840087890625 C 1770.580688476563 272.0494079589844 1743.470581054688 113.8814315795898 1734.432373046875 1.807641863822937 C 1725.394165039063 -110.2661514282227 1569.033203125 -170.8221588134766 1569.033203125 -170.8221588134766 C 1569.033203125 -170.8221588134766 1343.981689453125 -111.1699676513672 1341.270263671875 -110.2661514282227 C 1338.558837890625 -109.3623352050781 1260.830322265625 -14.46113395690918 1264.445556640625 1.807641863822937 C 1268.060791015625 18.07641792297363 1283.42236328125 527.830078125 1283.42236328125 527.830078125 Z" fill="#f61b39" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';