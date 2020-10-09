import 'package:flutter/material.dart';
import 'package:home_bakery_app/Product.dart';
import 'package:home_bakery_app/Order.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.item, this.name, this.quantity, this.amountToPay})
      : super(key: key);
  final Product item;
  final String name;
  final int quantity;
  final int amountToPay;
  @override
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _counter = 1;
  int _total = 1;
  String _specials;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _orderTotal();
      if (widget.item.name == "Cup cake") {
        if (_counter == 12) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Great! Order is now a special order!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        if (_counter == 10) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Great! Order is now a special order!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
            duration: Duration(seconds: 3),
          ));
        }
      }
    });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 40, bottom: 10),
              child: Icon(Icons.chevron_left, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _decrementCounter() {
    setState(() {
      if (_counter <= 1) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Oops! Sorry item ordered can not be less than 1 !'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
          duration: Duration(seconds: 3),
        ));
      } else {
        _counter--;
        _orderTotal();
      }
    });
  }

  void _orderTotal() {
    _total = _counter * widget.item.price;
  }

  @override
  Widget build(BuildContext context) {
    _total = _counter * widget.item.price;
    if (widget.item.name == "Cake slice") {
      _specials = "Cake slices minimum of 10";
    }
    if (widget.item.name == "Cup cake") {
      _specials = "Cup cakes minimum of 12";
    }
    if (widget.item.name == "Meat Pie") {
      _specials = "Meat pies minimum of 10";
    }
    return Scaffold(
        key: _scaffoldKey,
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              Stack(children: <Widget>[
                ClipPath(
                  child: AspectRatio(
                    aspectRatio: 12.0 / 9.0,
                    child: Image.asset(
                      "images/" + widget.item.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipper: BottomWaveClipper(),
                ),
                _backButton(),
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: Column(
                  // Default value for crossAxisAlignment is CrossAxisAlignment.center.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.item.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'DancingScript',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            child: SizedBox(
                          width: 20.0,
                        )),
                        Text(
                          "Price: " + "₦" + widget.item.price.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // Empty space:
                    SizedBox(height: 10.0),
                    Row(children: [
                      Icon(Icons.description, size: 20.0),
                      SizedBox(width: 5.0),
                      Text(
                        widget.item.description,
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 12.0,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                    ]),
                    SizedBox(height: 18.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 0.3,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15.0),

                    Text("Order",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 25.0),

                    Text("QUANTITY",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 15.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Required",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(height: 15.0),

                    Text("For special orders anytime:",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 15.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    Text("$_specials",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(height: 25.0),
                    Row(children: [
                      RaisedButton(
                        shape: StadiumBorder(),
                        onPressed: () {
                          _decrementCounter();
                        },
                        child: Text("-"),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$_counter",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 12.0,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                      SizedBox(width: 5.0),
                      RaisedButton(
                        shape: StadiumBorder(),
                        onPressed: () {
                          _incrementCounter();
                        },
                        child: Text("+"),
                      ),
                    ]),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("TOTAL:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Roboto-Medium',
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "₦" + "$_total",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'Roboto-Medium',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 200.0,
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      color: Colors.pink[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Order(
                              name: widget.item.name,
                              quantity: _counter,
                              amountToPay: _total,
                            ),
                          ),
                        );
                      },
                      child: Text("PROCEED",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'DancingScript')),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Home Bakery",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 20.0,
                        fontFamily: 'DancingScript',
                      )),
                  Text("By Rerhmarh Thani",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 15.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  Text(
                      "...freshly baked with care and a great taste in every bite!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: 'Roboto-Medium',
                      )),
                  SizedBox(height: 10.0),
                ],
              ),
            ]));
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

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
