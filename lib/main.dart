import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:home_bakery_app/Profile.dart';
import 'package:home_bakery_app/About.dart';
import 'package:home_bakery_app/Product.dart';
import 'package:home_bakery_app/ProductPage.dart';

final List<String> imgList = [
  'cakeslice.jpg',
  'chocolatecupcake.jpg',
  'cupcake.jpg',
  'meatpie.jpg',
];
void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Add the 3 lines from here...
      primaryColor: Colors.white,
    ),
    home: home_bakery_appBar()));

class home_bakery_appBar extends StatefulWidget {
  @override
  _home_bakery_appBarState createState() => _home_bakery_appBarState();
}

class _home_bakery_appBarState extends State<home_bakery_appBar> {
  GlobalKey _home_bakery_appigationKey = GlobalKey();
  final items = Product.getProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _home_bakery_appigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.info_outline_rounded, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.pink[200],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => home_bakery_appBar()));
          }
          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => info()));
          }
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => profile()));
          }
        },
      ),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              height: 250,
              child: Builder(
                builder: (context) {
                  final double height = MediaQuery.of(context).size.height;
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      // autoPlay: false,
                    ),
                    items: imgList
                        .map((item) => Container(
                              child: Card(
                                  child: Center(
                                child: ClipPath(
                                  child: Image.asset(
                                    "images/" + item,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                  ),
                                  clipper: BottomWaveClipper(),
                                ),
                              )),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Container(
                padding: EdgeInsets.all(2),
                child: Center(
                  child: Column(
                    children: <Widget>[
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
                      Row(
                        children: <Widget>[
                          Text(
                            "Weekly Yummies::",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'Roboto-Medium',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
                child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ProductBox(item: items[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(item: items[index]),
                      ),
                    );
                  },
                );
              },
            ))
          ]),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.item}) : super(key: key);
  final Product item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("images/" + this.item.image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.item.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DancingScript',
                            ),
                          ),
                          Text(
                            this.item.description,
                            style: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "Price: " + "₦" + this.item.price.toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )))
            ])));
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
