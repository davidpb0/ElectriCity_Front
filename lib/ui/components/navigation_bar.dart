import 'package:electricity_front/ui/views/prizespage.dart';
import 'package:electricity_front/ui/views/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../views/listpage.dart';
import '../views/mapa.dart';
import 'info_personal_ubi_form.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  static final List<Widget> _widgetOptions = <Widget>[
    GoogleMapa(),
    ListPage(),
    //InfoPersonalUbiForm(),
    const PrizesPage(),
    const ProfilePage(),
    //ProfilePage()
  ];
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
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
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.map), label: AppLocalizations.of(context).homepage_map),
          BottomNavigationBarItem(icon: const Icon(Icons.electric_car), label: AppLocalizations.of(context).homepage_stations),
          BottomNavigationBarItem(icon: const Icon(Icons.military_tech), label: AppLocalizations.of(context).homepage_prizes),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppLocalizations.of(context).homepage_profile)
        ],
      ),
    );
  }
}
