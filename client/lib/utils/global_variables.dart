import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

bool isAuth = false;
String secretPageState = "";

List<Widget> quizListGlobal = [];
String quizNameGlobal = "";
String username = "";
String userId = "";

String globalState = "";
GetStorage box = GetStorage();

late IO.Socket socket;

void resetGlobalVariable() {
  isAuth = false;
  secretPageState = "";

  username = "";
  userId = "";
  globalState = "";
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}
