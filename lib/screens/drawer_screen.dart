import 'dart:ui';

import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/constants/drawer_items.dart';
import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff2D3436),
                    const Color(0xff2D3436).withOpacity(0.4),
                    // const Color(0xffD3D3D3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            DrawerScreenDetails(),
            Container(
              transform: Matrix4.translationValues(190, 160, 0)..scale(0.62),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xffD3D3D3).withOpacity(0.1),
                    const Color(0xff2D3436).withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}

class DrawerScreenDetails extends StatelessWidget {
  const DrawerScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Icon(
                          Icons.perm_identity,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hammad Memon',
                          style: kHeadlineSmall.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '+92-331-046002',
                          style: kUserAuthSubTitle.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              ...DrawerItems.all
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: ListTile(
                        leading: Icon(
                          e.iconData,
                          color:
                              e.title == 'Home' ? Colors.white : kPrimaryColor,
                        ),
                        title: Text(e.title),
                        selected: (e.title == 'Home' ? true : false),
                        selectedColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 25),
                        minVerticalPadding: 0,
                        style: ListTileStyle.drawer,
                        dense: true,
                        horizontalTitleGap: 10,
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 108,
                  child: ListTile(
                    leading: Icon(Icons.settings, color: kPrimaryColor),
                    title: Text('Settings'),
                    contentPadding: EdgeInsets.only(left: 0),
                    minVerticalPadding: 0,
                    style: ListTileStyle.drawer,
                    dense: true,
                    horizontalTitleGap: 0,
                  ),
                ),
                Container(
                  width: 2,
                  height: 16,
                  color: kPrimaryColor,
                  margin: const EdgeInsets.only(left: 6, right: 18),
                ),
                const SizedBox(
                  width: 108,
                  child: ListTile(
                    leading: Icon(Icons.logout_outlined, color: kPrimaryColor),
                    title: Text('LOGOUT'),
                    contentPadding: EdgeInsets.only(left: 0),
                    minVerticalPadding: 0,
                    style: ListTileStyle.drawer,
                    dense: true,
                    horizontalTitleGap: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
