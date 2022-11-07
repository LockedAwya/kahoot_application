import 'dart:async';

class StreamSocket {
  final socketResponse = StreamController();

  void Function(List<dynamic>) get addResponse => socketResponse.sink.add;
  Stream<dynamic> get getResponse => socketResponse.stream;

  void dispose() {
    socketResponse.close();
  }
}
