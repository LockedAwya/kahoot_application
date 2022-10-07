import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
String api_url = 'http://10.0.2.2:3000';
var dio = Dio();
