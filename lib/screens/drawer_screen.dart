import 'dart:ui';

import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/constants/drawer_items.dart';
import 'package:cinepax_flutter/screens/intermediary_transition_screen.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/drawer_state_provider.dart';

class DrawerScreen extends StatelessWidget {
  String? fromPaymentScreen;
  DrawerScreen({this.fromPaymentScreen});

  @override
  Widget build(BuildContext context) {
    print('drawer screen build called');
    return Scaffold(
      body: SafeArea(
        top: false,
        child: PropertyChangeProvider<DrawerStateProvider, String>(
          value: DrawerStateProvider(),
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
              Consumer<DrawerStateProvider>(
                builder: (context, provider, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    transform: Matrix4.translationValues(
                        provider.getXOffset, provider.getYOffset, 0)
                      ..scale(provider.getScaleFactor),
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
                  );
                },
              ),
              PropertyChangeConsumer<DrawerStateProvider, String>(
                properties: const ['DRAWER_SELECTED_ITEM'],
                builder: (context, provider, properties) {
                  if (fromPaymentScreen != null &&
                      fromPaymentScreen == 'Your Tickets') {
                    fromPaymentScreen = null;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      provider?.updateSelectedTileText('Your Tickets');
                    });
                    return IntermediaryTransitionScreen(screen: 'Your Tickets');
                  }
                  switch (provider?.getSelectedTileText) {
                    case 'Home':
                      return IntermediaryTransitionScreen(screen: 'Home');
                    case 'Your Tickets':
                      return IntermediaryTransitionScreen(
                          screen: 'Your Tickets');
                    default:
                      return IntermediaryTransitionScreen(screen: 'Default');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerScreenDetails extends StatelessWidget {
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
                      // backgroundColor: const Color(0xff2D3436).withOpacity(0.4),
                      backgroundColor: Colors.grey.withOpacity(0.6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.black.withOpacity(0.6),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hammad Memon',
                          style: kHeadlineSmall.copyWith(
                            color: kPrimaryColor,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '+92-331-046002',
                          style: kUserAuthSubTitle.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              ...DrawerItems.all
                  .map(
                    (e) => PropertyChangeConsumer<DrawerStateProvider, String>(
                      properties: const ['DRAWER_SELECTED_ITEM'],
                      builder: (context, provider, properties) {
                        return Container(
                          margin: const EdgeInsets.only(top: 14),
                          width: 180,
                          child: ListTile(
                            leading: Icon(
                              e.iconData,
                              color: e.title == provider?.getSelectedTileText
                                  ? Colors.white
                                  : kPrimaryColor,
                            ),
                            title: Text(
                              e.title,
                              style: const TextStyle(
                                letterSpacing: 0.7,
                              ),
                            ),
                            selected: (e.title == provider?.getSelectedTileText
                                ? true
                                : false),
                            selectedColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 25),
                            minVerticalPadding: 0,
                            style: ListTileStyle.drawer,
                            dense: true,
                            horizontalTitleGap: 10,
                            onTap: () {
                              provider?.updateSelectedTileText(e.title);
                            },
                          ),
                        );
                      },
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
