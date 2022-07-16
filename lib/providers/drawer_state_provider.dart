import 'package:cinepax_flutter/constants/drawer_items.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class DrawerStateProvider extends PropertyChangeNotifier<String> {
  bool _isDrawerOpen = false;
  String _selectedTile = DrawerItems.all.first.title;

  bool get isDrawerOpen {
    return _isDrawerOpen;
  }

  void openDrawer() {
    _isDrawerOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    _isDrawerOpen = false;
    notifyListeners();
  }

  double get getXOffset {
    return _isDrawerOpen ? 190 : 0;
  }

  double get getYOffset {
    return _isDrawerOpen ? 160 : 0;
  }

  double get getScaleFactor {
    return _isDrawerOpen ? 0.62 : 1;
  }

  void updateSelectedTileText(String tileText) {
    _selectedTile = tileText;
    print('$tileText called');
    notifyListeners('DRAWER_SELECTED_ITEM');
  }

  String get getSelectedTileText {
    return _selectedTile;
  }
}
