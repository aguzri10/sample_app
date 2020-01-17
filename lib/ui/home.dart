import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/api/base_url.dart';
import 'package:sample_app/ui/user_detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataFromJson;
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  Future<void> getData() async {
    // dataFromJson.clear();
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(Uri.encodeFull(BaseUrl.userlist),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        dataFromJson = jsonDecode(response.body);
        loading = false;
      });
    } else {
      print("Something Wrong");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert, color: Colors.white),
            )
          ],
          backgroundColor: Colors.redAccent,
          leading: Icon(Icons.dehaze, color: Colors.white),
          title: Text("User List"),
        ),
        body: RefreshIndicator(
          onRefresh: getData,
          key: _refresh,
          child: Center(
            child: loading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: dataFromJson == null ? 0 : dataFromJson.length,
                    itemBuilder: (context, i) {
                      return GestureDetector( 
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetail(dataFromJson[i]['id'])));
                        },
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(dataFromJson[i]['name']),
                                  Text(dataFromJson[i]['email'])
                                ],
                              ),
                              Icon(Icons.favorite)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
