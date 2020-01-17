import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  UserDetail(dataFromJson);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  List dataFromJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
        backgroundColor: Colors.redAccent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: <Widget>[
          Icon(Icons.more_vert, color: Colors.white)
        ],
      ),
      body: Center(
        child: Text(""),
      ),
    );
  }
}