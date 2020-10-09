import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter/foundation.dart';

class OrderSummary extends StatefulWidget {
  OrderSummary({
    Key key,
    @required this.name,
    @required this.quantity,
    @required this.amountToPay,
    @required this.username,
    @required this.userphone,
    @required this.deliverylocation,
    @required this.ordertype,
    @required this.retrievalmethod,
  }) : super(key: key);

  final String name;
  final int quantity;
  final int amountToPay;
  final String username;
  final String userphone;
  final String deliverylocation;
  final String ordertype;
  final String retrievalmethod;
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  String _platformVersion = 'Unknown';
  String _message, body;
  String _canSendSMSMessage = "Check is not run.";
  List<String> people = ["+2348140799190"];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void _sendSMS(List<String> recipents) async {
    try {
      String _result = await sendSMS(
          message: "     HOME BAKERY \n\n" +
              "Order Details \n\n" +
              "Order type:" +
              widget.ordertype +
              "\nItem Order:" +
              widget.quantity.toString() +
              " x " +
              widget.name +
              "\n\nCustomer details \n\n" +
              "Name: " +
              widget.username +
              "\nPhone: " +
              widget.userphone +
              "\nDelivery Location: " +
              widget.deliverylocation +
              "\nRetrieval Method: " +
              widget.retrievalmethod +
              "\n\nTotal: " +
              "₦" +
              widget.amountToPay.toString(),
          recipients: recipents);
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _submitOrder() async {
    switch (await showDialog<Selection>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('How would you like to send your order ?'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Selection.whatsapp);
                },
                child: const Text('Via Whatsapp'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Selection.sms);
                },
                child: const Text('Via Sms'),
              ),
            ],
          );
        })) {
      case Selection.whatsapp:
        // Let's go.
        // ...
        FlutterOpenWhatsapp.sendSingleMessage(
            "+2348140799190",
            "     HOME BAKERY \n\n" +
                "Order Details \n\n" +
                "Order type:" +
                widget.ordertype +
                "\nItem Order:" +
                widget.quantity.toString() +
                " x " +
                widget.name +
                "\n\nCustomer details \n\n" +
                "Name: " +
                widget.username +
                "\nPhone: " +
                widget.userphone +
                "\nDelivery Location: " +
                widget.deliverylocation +
                "\nRetrieval Method: " +
                widget.retrievalmethod +
                "\n\nTotal: " +
                "₦" +
                widget.amountToPay.toString());

        break;
      case Selection.sms:
        // ...
        _sendSMS(people);

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Order summary',
            style: TextStyle(color: Colors.pink[200]),
          ),
        ),
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Order Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Order type",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    Text(widget.ordertype,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Item Ordered ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    Text(widget.quantity.toString() + " x " + widget.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 0.3,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text("Customer Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Name: " + widget.username,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Phone: " + widget.userphone,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Delivery Location: " + widget.deliverylocation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Retrieval Method: " + widget.retrievalmethod,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'Roboto-Medium',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 0.3,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text("Total :" + "₦" + widget.amountToPay.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Roboto-Medium',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10.0),
                  ],
                ),
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
                        _submitOrder();
                      },
                      child: Text("SUBMIT",
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
            ]));
  }
}

enum Selection { whatsapp, sms }
