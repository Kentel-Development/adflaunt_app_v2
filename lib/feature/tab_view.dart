import 'package:adflaunt/feature/booking_list/booking_list_view.dart';
import 'package:adflaunt/feature/calendar/calendar_view.dart';
import 'package:adflaunt/feature/home/home_view.dart';
import 'package:adflaunt/feature/inbox/inbox_view.dart';
import 'package:adflaunt/product/services/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../core/constants/color_constants.dart';
import '../core/constants/icon_constants.dart';
import '../generated/l10n.dart';
import 'profile/profile_view.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListingsAPI.getUserListings(),
        builder: (context, snapshot) {
          final List<Widget> _widgetOptions = <Widget>[
            HomeView(),
            BookingListView(),
            InboxView(),
            ProfileView(
              isFromDrawer: true,
            ),
          ];
          final List<String> _titles = [
            S.of(context).home,
            S.of(context).booking,
            S.of(context).chat,
            S.of(context).profile
          ];
          final List<String> _activeIcons = [
            IconConstants.home_active,
            IconConstants.booking_active,
            IconConstants.inbox_active,
            IconConstants.profile_active
          ];
          final List<String> _unactiveIcons = [
            IconConstants.home_unactive,
            IconConstants.booking_unactive,
            IconConstants.inbox_unactive,
            IconConstants.profile_unactive
          ];
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              _widgetOptions.insert(2, CalendarView());
              _titles.insert(2, S.of(context).calendar);
              _activeIcons.insert(2, IconConstants.calendar_active);
              _unactiveIcons.insert(2, IconConstants.calendar_unactive);
            }
          }

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
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                      selectedColorOpacity: 1,
                      currentIndex: _selectedIndex,
                      onTap: (i) => setState(() => _selectedIndex = i),
                      items: List.generate(_widgetOptions.length, (index) {
                        return SalomonBottomBarItem(
                          icon: SvgPicture.asset(
                            _selectedIndex == index
                                ? _activeIcons[index]
                                : _unactiveIcons[index],
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            _titles[index],
                            style: TextStyle(
                                color: const Color.fromRGBO(250, 250, 250, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          selectedColor: ColorConstants.colorPrimary,
                        );
                      })),
                ),
              ),
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
          );
        });
  }
}
