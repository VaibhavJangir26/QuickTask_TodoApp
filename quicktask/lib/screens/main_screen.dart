import 'dart:io';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/screens/account_screen.dart';
import 'package:quicktask/screens/home_screen.dart';
import 'package:quicktask/utility/no_internet_screen.dart';

import '../providers/internet_connection_check_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _navIndexController = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveIcon: const Icon(Icons.home_outlined),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveIcon: const Icon(Icons.person_outline),
      ),
    ];
  }

  Future<bool> onWillPop() async {
    if (_navIndexController.index == 0) {
      exit(0);
    }
    return false;
  }

  List<Widget> screens() {
    return [
      WillPopScope(onWillPop: onWillPop, child: const HomeScreen()),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final internetProvider = Provider.of<InternetConnectionCheckProvider>(context, listen: true);

    return Scaffold(
      body: internetProvider.isConnectedToInternet ? PersistentTabView(
        context,
        screens: screens(),
        items: navBarItems(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        controller: _navIndexController,
        navBarStyle: NavBarStyle.simple,
      ) : const NoInternetScreen(),
    );
  }
}
