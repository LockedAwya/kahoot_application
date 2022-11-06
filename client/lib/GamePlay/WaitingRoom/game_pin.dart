import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/global_variables.dart';
import '../../utils/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GamePin extends StatefulWidget {
  //final int gameId;
  //final String username;
  var gameData;
  GamePin({Key? key, required this.gameData}) : super(key: key);

  @override
  _GamePinState createState() => _GamePinState();
}

class _GamePinState extends State<GamePin> {
  List<String> gamePin = [
    'KhoaAssassin',
    'Vuong Vu Duc Hoang',
    'Ngo Duc Manh',
    'player 1',
    'player 2',
    'pLayer 3'
  ];
  //List<String> gamePin = []; //display "Waiting for player if there are no players"

  void initSocket() {
    socket = IO.io(
      'http://10.0.2.2:3003',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          //.disableAutoConnect()
          // .setQuery(
          //     {'username': widget.username})
          .enableForceNew()
          .build(),
    );
    socket.connect();
    socket.onConnect(
        (data) => print('Connection established with id ${socket.id}'));
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect(
        (data) => print('Socket.IO server disconnected with id ${socket.id}'));
    socket.emit("msg", "test1234");
    print("Game data is: ");
    print(widget.gameData);
    socket.emit("create-game", widget.gameData);
    //_connectSocket();
  }

  @override
  void initState() {
    // TODO: implement initState
    //print("LMAO");
    super.initState();
    setState(() => {initSocket()});
  }

  // @override
  // void didUpdateWidget(GamePin oldWidget) {
  //   debugPrint('State didUpdateWidget');
  //   super.didUpdateWidget(oldWidget);
  //   initSocket();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            alignment: Alignment.center,
            iconSize: 20,
            onPressed: () {
              setState(() => {
                    socket.emit("delete-game", widget.gameData["gameId"]),
                    socket.dispose(),
                    print(socket.connected)
                  });
              Navigator.of(context).pop();
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => super.widget));
            },
            icon: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Game pin: ${widget.gameData['gameId']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/ic_user.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "0",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Kahoot!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text("Start",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            //alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: gamePin.isNotEmpty
                ? GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 80 / 36),
                    itemBuilder: (_, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white),
                        child: Text(gamePin[index],
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal)),
                      );
                    },
                    itemCount: gamePin.length,
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Wating for player.....",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
