import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _userphone = TextEditingController();
  TextEditingController _deliverylocation = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String uName;
  String uPhone;
  String uDlocation;
  GlobalKey _home_bakery_appigationKey = GlobalKey();

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _username.text);
    prefs.setString('userPhone', _userphone.text);
    prefs.setString('userdeliveryaddress', _deliverylocation.text);

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Profile updated!'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      duration: Duration(seconds: 3),
    ));
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    uName = prefs.getString('userName');

    uPhone = prefs.getString('userPhone');
    uDlocation = prefs.getString('userdeliveryaddress');

    if (uName != null) {
      _username.text = uName;
      _username.value = TextEditingValue(
        text: uName,
        selection: TextSelection.fromPosition(
          TextPosition(offset: uName.length),
        ),
      );
    }

    if (uPhone != null) {
      _userphone.text = uPhone;
      _userphone.value = TextEditingValue(
        text: uPhone,
        selection: TextSelection.fromPosition(
          TextPosition(offset: uPhone.length),
        ),
      );
    }
    if (uDlocation != null) {
      _deliverylocation.text = uDlocation;
      _deliverylocation.value = TextEditingValue(
        text: uDlocation,
        selection: TextSelection.fromPosition(
          TextPosition(offset: uDlocation.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getStringValuesSF();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Roboto-Medium',
            ),
          ),
        ),
        /*home_bakery_appigationBar: CurvedNavigationBar(
          key: _home_bakery_appigationKey,
          index: 2,
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
        ),*/
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Customer Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: 0.3,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Note*: This information will be used when sending your order.",
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 10.0,
                      fontFamily: 'Roboto-Medium',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _username,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What do people call you?',
                      labelText: 'Name *',
                    ),
                  ),
                  TextField(
                    controller: _userphone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone_iphone),
                      hintText: 'Phone number?',
                      labelText: 'Phone *',
                    ),
                  ),
                  TextField(
                    controller: _deliverylocation,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_on),
                      hintText: 'Where would you like your item delivered?',
                      labelText: 'Delivery Address *',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          color: Colors.pink[200],
                          onPressed: () {
                            addStringToSF();
                          },
                          child: Text("UPDATE",
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
                    ],
                  ),
                ],
              )
            ]));
  }
}
