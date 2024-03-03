import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/features/patient/home/presentation/homeView.dart';
import 'package:se7ety/features/patient/profile/profile.dart';
import 'package:se7ety/features/patient/search/presentation/view/searchView.dart';
import 'package:se7ety/features/patient/appointment/myAppointment.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

int _selectedIndex = 0;
final List _page = [
  const homeView(),
  const searchView(),
  const timeView(),
  const profileView()
];

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user;

Future<void> _getUser() async {
  user = _auth.currentUser;
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _page[_selectedIndex],
        // child: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: const Color.fromARGB(255, 190, 26, 26),
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: appColors.bottonColor,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'الرئيسيه',
                    iconActiveColor: appColors.scaffColor,
                    textStyle: TextStyle(
                        color: appColors.scaffColor,
                        fontFamily: GoogleFonts.cairo().fontFamily),
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'البحث',
                    iconActiveColor: appColors.scaffColor,
                    textStyle: TextStyle(
                        color: appColors.scaffColor,
                        fontFamily: GoogleFonts.cairo().fontFamily),
                  ),
                  GButton(
                    icon: Icons.date_range_outlined,
                    text: 'المواعيد',
                    textStyle: TextStyle(
                        color: appColors.scaffColor,
                        fontFamily: GoogleFonts.cairo().fontFamily),
                    iconActiveColor: appColors.scaffColor,
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'الحساب',
                    textStyle: TextStyle(
                        color: appColors.scaffColor,
                        fontFamily: GoogleFonts.cairo().fontFamily),
                    iconActiveColor: appColors.scaffColor,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ))));
  }
}
