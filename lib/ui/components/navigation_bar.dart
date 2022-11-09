import 'package:electricity_front/ui/views/listpage.dart';
import 'package:electricity_front/ui/views/profilepage.dart';
import 'package:flutter/material.dart';

import '../views/mapa.dart';


class BottomBar extends StatefulWidget{
  const BottomBar({super.key});


  @override
  _BottomBarState createState() => _BottomBarState();

}

class _BottomBarState extends State<BottomBar>{
  static final List<Widget> _widgetOptions = <Widget>[
    Google_Mapa(),
    ListPage(),
    //const Text("Mobility"),
    const Text("Prizes"),
    ProfilePage(),
    //ProfilePage()

  ];
  var _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color(0xFF526480),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.electric_car), label: "Mobility"),
          BottomNavigationBarItem(icon: Icon(Icons.military_tech), label: "Prizes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],

      ),


    );

  }


}