import 'package:flutter/material.dart';
import 'package:home_bakery_app/OrderSummary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  Order(
      {Key key,
      @required this.name,
      @required this.quantity,
      @required this.amountToPay,
      this.username,
      this.userphone,
      this.deliverylocation,
      this.ordertype,
      this.retrievalmethod})
      : super(key: key);
  final String name;
  final int quantity;
  final int amountToPay;
  final String username;
  final String userphone;
  final String deliverylocation;
  final String ordertype;
  final String retrievalmethod;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String _orderType, _retrievalmethod;
  Choice _character = Choice.myself;
  bool _visibility = false;
  final formKey = new GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _userphone = TextEditingController();
  TextEditingController _deliverylocation = TextEditingController();

  String uName;
  String uPhone;
  String uDlocation;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _username.text);
    prefs.setString('userPhone', _userphone.text);
    prefs.setString('userdeliveryaddress', _deliverylocation.text);
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
      if (_visibility == false) {
        _deliverylocation.text = "";
      } else {
        _deliverylocation.text = uDlocation;
        _deliverylocation.value = TextEditingValue(
          text: uDlocation,
          selection: TextSelection.fromPosition(
            TextPosition(offset: uDlocation.length),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_visibility == false) {
      _deliverylocation.text = "";
      _retrievalmethod = "Retrieve myself";
    }
    getStringValuesSF();

    if (widget.name == "Cake slice" && widget.quantity >= 10) {
      _orderType = "Special Order";
    }

    if (widget.name == "Cup cake" && widget.quantity >= 12) {
      _orderType = "Special Order";
    }

    if (widget.name == "Meat Pie" && widget.quantity >= 10) {
      _orderType = "Special Order";
    }

    if (widget.name == "Cake slice" && widget.quantity < 10) {
      _orderType = "Regular Order";
    }

    if (widget.name == "Cup cake" && widget.quantity < 12) {
      _orderType = "Regular Order";
    }

    if (widget.name == "Meat Pie" && widget.quantity < 10) {
      _orderType = "Regular Order";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order details',
            style: TextStyle(color: Colors.pink[200]),
          ),
        ),
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'DancingScript',
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                                widget.quantity.toString() +
                                    " x " +
                                    widget.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontFamily: 'Roboto-Medium',
                                )),
                            Expanded(
                                child: SizedBox(
                              width: 20.0,
                            )),
                            Text(
                              "Total: " + "₦" + widget.amountToPay.toString(),
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
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            child: Text(
                              "OrderType:  " + "$_orderType",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Roboto-Medium',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 0.3,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Customer details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Roboto-Medium',
                      ),
                    ),
                    Text(
                      "* fields are required.",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 10.0,
                        fontFamily: 'Roboto-Medium',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: _username,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'What do people call you?',
                          labelText: 'Name *',
                        ),
                        onSaved: (val) => _username.text = val.trim(),
                        validator: (val) {
                          return val.isEmpty ? "Please enter your name" : null;
                        }),
                    TextFormField(
                        controller: _userphone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone_iphone),
                          hintText: 'Phone number?',
                          labelText: 'Phone *',
                        ),
                        onSaved: (val) => _userphone.text = val.trim(),
                        validator: (val) {
                          return val.isEmpty
                              ? "Please enter your phone number"
                              : null;
                        }),
                    Visibility(
                      child: TextFormField(
                          controller: _deliverylocation,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.location_on),
                            hintText:
                                'Where would you like your item delivered?',
                            labelText: 'Delivery Address *',
                          ),
                          onSaved: (val) => _deliverylocation.text = val.trim(),
                          validator: (val) {
                            return val.isEmpty
                                ? "Please enter delivery location"
                                : null;
                          }),
                      visible: _visibility,
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 0.3,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        child: Text(
                          "Retrieval Method:  ",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Retrieve myself'),
                          leading: Radio(
                              value: Choice.myself,
                              groupValue: _character,
                              onChanged: (Choice value) {
                                setState(() {
                                  _character = value;
                                  _visibility = false;
                                  _retrievalmethod = "Retrieve myself";
                                });
                              },
                              activeColor: Colors.pink[200]),
                        ),
                        ListTile(
                          title: const Text('Deliver to me'),
                          leading: Radio(
                            value: Choice.delivered,
                            groupValue: _character,
                            onChanged: (Choice value) {
                              setState(() {
                                _character = value;
                                _visibility = true;
                                _retrievalmethod = "Deliver to me";
                              });
                            },
                            activeColor: Colors.pink[200],
                          ),
                        ),
                      ],
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
                              final form = formKey.currentState;

                              if (form.validate()) {
                                form.save();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSummary(
                                      name: widget.name,
                                      quantity: widget.quantity,
                                      amountToPay: widget.amountToPay,
                                      username: _username.text,
                                      userphone: _userphone.text,
                                      deliverylocation: _deliverylocation.text,
                                      ordertype: _orderType,
                                      retrievalmethod: _retrievalmethod,
                                    ),
                                  ),
                                );
                              }
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
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ]),
                ),
              ),
            ]));
  }
}

enum Choice { myself, delivered }
