import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:math';

late SharedPreferences prefs;

bool isAuth = false;
String secretPageState = "";

List<Widget> quizListGlobal = [];
String quizNameGlobal = "";

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
