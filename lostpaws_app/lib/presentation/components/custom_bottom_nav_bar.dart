import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      late String route;
      _selectedIndex = index;

      switch (_selectedIndex) {
        case 0:
          route = HomeLocations.mapViewRoute;
          break;
        case 1:
          route = HomeLocations.createPostingRoute;
          break;
        case 2:
          route = HomeLocations.homeRoute;
          break;
        case 3:
          route = HomeLocations.profileRoute;
          break;
      }

      Beamer.of(context).beamToNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: ConstColors.mediumGreen,
      ),
      child: BottomNavigationBar(
        backgroundColor: ConstColors.mediumGreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Map View",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded),
            label: "Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ConstColors.yellowOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}
