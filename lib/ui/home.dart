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
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  Future<List> getData() async {
    // dataFromJson.clear();
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(Uri.encodeFull(BaseUrl.userlist),
        headers: {"Accept": "application/json"});

    // return jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      return jsonDecode(response.body);
    } else {
      print("Something Wrong");
    }
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
              : FutureBuilder<List>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ItemList(
                            list: snapshot.data,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserDetail(
                  list: list,
                  index: i
                )));
          },
          child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(list[i]['name']),
                subtitle: Text(list[i]['email']),
                trailing: Icon(Icons.favorite),
              )),
        );
      },
    );
  }
}
