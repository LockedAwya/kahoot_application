import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StreamSocket {
  final socketResponse = BehaviorSubject<dynamic>();

  void Function(dynamic) get addResponse => socketResponse.sink.add;
  Stream<dynamic> get getResponse => socketResponse.stream;

  void dispose() {
    socketResponse.close();
  }
}
