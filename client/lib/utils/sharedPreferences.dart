// import 'package:shared_preferences/shared_preferences.dart';

// late SharedPreferences prefs;

// // Future<SharedPreferences> getSharedPreferenceInstance() async {
// //   prefs = await SharedPreferences.getInstance();
// //   return prefs;
// // }
// // //setter
// // class shared_preferences {
// //   static getSharedPreferenceInstance() async {
// //     return await SharedPreferences.getInstance();
// //   }

// //   static setter(String key, dynamic value) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     if (value is String) {
// //       getSharedPreferenceInstance().setString(key, value);
// //     } else if (value is int) {
// //       getSharedPreferenceInstance().setInt(key, value);
// //     } else if (value is double) {
// //       getSharedPreferenceInstance().setDouble(key, value);
// //     } else if (value is bool) {
// //       getSharedPreferenceInstance().setBool(key, value);
// //     }
// //   }

// //   static Future<String?> stringGetter(String key) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return getSharedPreferenceInstance().getString(key);
// //   }

// //   static Future<String?> intGetter(String key) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return getSharedPreferenceInstance().getInt(key);
// //   }

// //   static Future<double?> doubleGetter(String key) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return getSharedPreferenceInstance().getDouble(key);
// //   }

// //   static Future<bool?> boolGetter(String key) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return getSharedPreferenceInstance().getBool(key);
// //   }

// //   //delete
// //   static removeValues(SharedPreferences prefs, String key) async {
// //     //SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.remove(key);
// //   }
// // }
