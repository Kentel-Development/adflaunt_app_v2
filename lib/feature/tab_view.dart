import 'package:adflaunt/feature/home/home_view.dart';
import 'package:adflaunt/feature/inbox/inbox_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../core/constants/color_constants.dart';
import '../core/constants/icon_constants.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Placeholder(),
    Placeholder(),
    InboxView(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromRGBO(215, 215, 215, 1),
            ),
            child: SalomonBottomBar(
              itemPadding: EdgeInsets.symmetric(horizontal: 19, vertical: 16),
              selectedColorOpacity: 1,
              currentIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
              items: [
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    _selectedIndex == 0
                        ? IconConstants.home_active
                        : IconConstants.home_unactive,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                        color: const Color.fromRGBO(250, 250, 250, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  selectedColor: ColorConstants.colorPrimary,
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    _selectedIndex == 1
                        ? IconConstants.like
                        : IconConstants.like,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Favorites',
                    style: TextStyle(
                        color: const Color.fromRGBO(250, 250, 250, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  selectedColor: ColorConstants.colorPrimary,
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    _selectedIndex == 2
                        ? IconConstants.booking_active
                        : IconConstants.booking_unactive,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Booking',
                    style: TextStyle(
                        color: const Color.fromRGBO(250, 250, 250, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  selectedColor: ColorConstants.colorPrimary,
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    _selectedIndex == 3
                        ? IconConstants.inbox_active
                        : IconConstants.inbox_unactive,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Chat',
                    style: TextStyle(
                        color: const Color.fromRGBO(250, 250, 250, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  selectedColor: ColorConstants.colorPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
