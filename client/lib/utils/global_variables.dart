import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


bool isAuth = false;
String secretPageState = "";

List<Widget> quizListGlobal = [];
String quizNameGlobal = "";
String username = "";
String userId = "";

// void initGetStorage() async {
//   await GetStorage.init();
// }
GetStorage box = GetStorage();

void resetGlobalVariable() {
  isAuth = false;
  secretPageState = "";

  username = "";
  userId = "";
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
