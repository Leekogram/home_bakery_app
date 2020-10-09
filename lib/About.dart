import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class info extends StatelessWidget {
  GlobalKey _home_bakery_appigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final String phone = 'tel:+2348140799190';
    _callPhone() async {
      if (await canLaunch(phone)) {
        await launch(phone);
      } else {
        throw 'Could not Call Phone';
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About Home Bakery',
            style: TextStyle(
              fontFamily: 'Roboto-Medium',
            ),
          ),
        ),
        body: Container(
            child: CustomPaint(
                child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                    children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Home Bakery",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 22.0,
                        fontFamily: 'DancingScript',
                      )),
                  Text("By Rerhmarh Thani",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  Text(
                      "...freshly baked with care and a great taste in every bite!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  SizedBox(height: 10.0),
                  Text("W H A T S A P P : (+234) 08140799190",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  SizedBox(height: 10.0),
                  Text("I G: rerhmarh_thani",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  SizedBox(height: 16.0),
                  Text("A D D R E S S: Bukan Sidi Lafia, Nasarawa State.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  SizedBox(height: 10.0),
                  RaisedButton.icon(
                    shape: StadiumBorder(),
                    color: Colors.pink[200],
                    onPressed: () {
                      _callPhone();
                    },
                    label: Text(
                      "HOME BAKERY",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Developed By:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'DancingScript',
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Leekogram",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'DancingScript',
                      )),
                  Text("W h a t s a p p : (+234) 07051482123",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'DancingScript',
                      )),
                  SizedBox(height: 10.0),
                  Text("E m a i l: Leekogram@gmail.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'DancingScript',
                      )),
                ],
              )
            ]))));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.pink[100];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
