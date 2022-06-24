import 'package:flutter/material.dart';

import '../models/drawer_item.dart';

class DrawerItems {
  static final List<DrawerItem> all = [
    DrawerItem(title: 'Home', iconData: Icons.home),
    DrawerItem(title: 'Your Tickets', iconData: Icons.my_library_add_rounded),
    DrawerItem(title: 'Favorites', iconData: Icons.favorite),
    DrawerItem(title: 'Upcoming', iconData: Icons.new_releases_rounded),
    DrawerItem(title: 'Profile', iconData: Icons.perm_contact_calendar),
    DrawerItem(title: 'About', iconData: Icons.description),
    // DrawerItem(title: 'Settings', iconData: Icons.settings),
    // DrawerItem(title: 'Logout', iconData: Icons.logout),
  ];
}
