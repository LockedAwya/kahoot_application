import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

late SharedPreferences prefs;

bool isAuth = false;
String secretPageState = "";

List<Widget> quizListGlobal = [];
