import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

bool isAuth = false;
String secretPageState = "";
