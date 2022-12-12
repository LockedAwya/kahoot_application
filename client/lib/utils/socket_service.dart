import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket currentSocket;

void setSocket(newSocket) {
  currentSocket = newSocket;
}

IO.Socket getSocket() {
  return currentSocket;
}
