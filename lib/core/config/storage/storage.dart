import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<bool> getBooleans(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool bl= false;
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }
  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

   static Future<List<String>> getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> temp =[];
    return prefs.getStringList(key) ?? temp;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool set = await prefs.setStringList(key, value);
     if(set==true){
        return true;
     }else{
       return false;
     }
  }
  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.clear() ?? false;
  }
}
