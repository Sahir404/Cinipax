import 'package:cinepax_flutter/constants/custom_icons.dart';
import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:cinepax_flutter/screens/your_tickets_screen.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:animate_icons/animate_icons.dart';
import '../providers/drawer_state_provider.dart';
import 'default_screen.dart';

class IntermediaryTransitionScreen extends StatefulWidget {
  static const routeName = 'home-screen/';
  final String screen;

  IntermediaryTransitionScreen({required this.screen});

  @override
  State<IntermediaryTransitionScreen> createState() =>
      _IntermediaryTransitionScreenState();
}

class _IntermediaryTransitionScreenState
    extends State<IntermediaryTransitionScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;
  bool isDragging = false;
  late AnimateIconController _animateIconController;
  late final DrawerStateProvider _drawerStateProvider;

  @override
  void initState() {
    _animateIconController = AnimateIconController();
    _drawerStateProvider =
        Provider.of<DrawerStateProvider>(context, listen: false);
    _closeDrawer();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IntermediaryTransitionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _closeDrawer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      _drawerStateProvider.closeDrawer();
    });
    if (_animateIconController.isEnd()) {
      _animateIconController.animateToStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('intermediary build called');
    return PropertyChangeConsumer<DrawerStateProvider, String>(
      properties: const ['DRAWER_SELECTED_ITEM'],
      builder: (context, provider, properties) {
        return WillPopScope(
          onWillPop: () async {
            if (isDrawerOpen) {
              _closeDrawer();
              _drawerStateProvider.closeDrawer();
              if (_animateIconController.isEnd()) {
                _animateIconController.animateToStart();
              }
              return false;
            } else {
              if (widget.screen != 'Home') {
                provider?.updateSelectedTileText('Home');
                return false;
              } else {
                return true;
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            child: GestureDetector(
              onTap: () {
                if (isDrawerOpen) {
                  _closeDrawer();
                  _drawerStateProvider.closeDrawer();
                  if (_animateIconController.isEnd()) {
                    _animateIconController.animateToStart();
                  }
                }
              },
              onHorizontalDragStart: (details) {
                isDragging = true;
              },
              onHorizontalDragUpdate: (details) {
                if (!isDragging) return;
                const delta = 1;
                if (details.delta.dx < -delta) {
                  _closeDrawer();
                  _drawerStateProvider.closeDrawer();
                  if (_animateIconController.isEnd()) {
                    _animateIconController.animateToStart();
                  }
                }
                isDragging = false;
              },
              child: AbsorbPointer(
                absorbing: isDrawerOpen ? true : false,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Stack(
                        children: [
                          if (widget.screen == 'Home') HomeScreen(),
                          if (widget.screen == 'Your Tickets')
                            YourTicketsScreen(),
                          if (widget.screen == 'Default') DefaultScreen(),
                          Positioned(
                            top: 40,
                            left: 14,
                            child: AnimateIcons(
                              startIcon: CustomIcons.left_alignment,
                              endIcon: CustomIcons.arrow_left_1,
                              onEndIconPress: () {
                                _closeDrawer();
                                _drawerStateProvider.closeDrawer();
                                return true;
                              },
                              onStartIconPress: () {
                                _openDrawer();
                                _drawerStateProvider.openDrawer();
                                return true;
                              },
                              duration: const Duration(milliseconds: 400),
                              controller: _animateIconController,
                              startIconColor: widget.screen == 'Home'
                                  ? Colors.white54
                                  : Colors.black54,
                              endIconColor: widget.screen == 'Home'
                                  ? Colors.white54
                                  : Colors.black54,
                              clockwise: false,
                              size: 34,
                            ),
                          ),
                          Positioned(
                            top: 48,
                            right: 20,
                            child: widget.screen == 'Home'
                                ? Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white54),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.search_rounded,
                                      size: 28,
                                      color: Colors.white70,
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openDrawer() {
    setState(() {
      xOffset = 220;
      yOffset = 130;
      scaleFactor = 0.7;
      isDrawerOpen = true;
    });
  }

  void _closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }
}
