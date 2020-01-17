import 'package:flutter/material.dart';
import 'package:sample_app/ui/search.dart';
import 'package:sample_app/ui/account.dart';
import 'package:sample_app/ui/home.dart';
import 'package:sample_app/ui/invite.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Sample App",
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  int i = 0;
  final List<Widget> pages = [Home(), Account(), Invite(), Search()];

  void _incrementTab(index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: i,
        onTap: (index) {
          _incrementTab(index);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: Colors.redAccent),
            icon: Icon(Icons.favorite, color: Colors.grey),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_circle, color: Colors.redAccent),
            icon: Icon(Icons.account_circle, color: Colors.grey),
            title: Text(
              "Account",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.insert_invitation, color: Colors.redAccent),
            icon: Icon(Icons.favorite, color: Colors.grey),
            title: Text(
              "Invite",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search, color: Colors.redAccent),
            icon: Icon(Icons.search, color: Colors.grey),
            title: Text(
              "Search",
              style: TextStyle(color: Colors.redAccent),
            ),
          )
        ],
      ),
    );
  }
}
