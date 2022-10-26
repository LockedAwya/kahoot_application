import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';

bool isAuth = false;
String secretPageState = "";

List<Widget> quizListGlobal = [];
String quizNameGlobal = "";
String username = "";
String userId = "";

void resetGlobalVariable() {
  isAuth = false;
  secretPageState = "";

  username = "";
  userId = "";
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
