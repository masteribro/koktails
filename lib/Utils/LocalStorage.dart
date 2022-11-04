import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage {


  static SharedPreferences? _preferences;
  static const _listOfFavorite = 'favourite';
  static const _listOfIconsId = 'Icons';
  static const _favoriteBool = 'favouriteBool';
  static Future init() async => _preferences = await SharedPreferences.getInstance();
  static Future setFavorite(List<String> List) async => await _preferences?.setStringList(_listOfFavorite, List);
  static List<String>? getList() => _preferences?.getStringList(_listOfFavorite);
  static Future setIcon(List<String> ListofIcon) async => await _preferences?.setStringList(_listOfIconsId, ListofIcon);
  static List<String>? getIcon() => _preferences?.getStringList(_listOfIconsId);
  static Future setFavoriteBool(bool bool) async => await _preferences?.setBool(_favoriteBool, bool);
  static bool? getFavouriteBool() => _preferences?.getBool(_favoriteBool);
  // Remove data for the 'counter' key.
  static Future<bool>? removed() => _preferences?.clear();
}