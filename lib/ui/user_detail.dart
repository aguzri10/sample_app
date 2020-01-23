import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final List list;
  final int index;

  UserDetail({this.list, this.index});

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  String address, company;
  var loading;
  int id;

  setup() {
    id = widget.list[widget.index]['id'];
    
    String street = widget.list[widget.index]['address']['street'];
    String suite = widget.list[widget.index]['address']['suite'];
    String city = widget.list[widget.index]['address']['city'];
    String zipcode = widget.list[widget.index]['address']['zipcode'];
    String name = widget.list[widget.index]['company']['name'];
    String catchPhrase = widget.list[widget.index]['company']['catchPhrase'];

    address = street + ', ' + suite + ', ' + city + ', ' + zipcode;
    company = name + ', ' + catchPhrase;

  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(widget.list[widget.index]['name']),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Email'),
            Text(widget.list[widget.index]['email']),
            SizedBox(height: 16),

            Text('Phone'),
            Text(widget.list[widget.index]['phone']),
            SizedBox(height: 16),

            Text('Website'),
            Text(widget.list[widget.index]['website']),
            SizedBox(height: 16),

            Text('Address'),
            Text(address),
            SizedBox(height: 16),

            Text('Company'),
            Text(company),
            SizedBox(height: 16),
          ],
        ),
      )
    );
  }
}