const { instrument } = require('@socket.io/admin-ui');

const app = require('express')()
const http = require('http').createServer(app)
const PORT = 3003;

const io = require("socket.io")(http)

let game;
let leaderboard;
let players = [];

const addPlayer = (userName, socketId) => {
  !players.some((player) => player.socketId === socketId) &&
    players.push({ userName, socketId })
  console.log(players);
}

const getPlayer = (socketId) => {
  return players.find((player) => player.socketId === socketId)
}

io.on("connection", (socket) => {
  console.log('a user connected with socket id ', socket.id);
  socket.on("disconnect", () => {
    console.log(socket.id + " was disconnected")
    //socket.destroy();
    //console.log(error)
  })
  socket.on('msg', (data) => {
    console.log('data from default ', data);
    socket.emit('fromServer', "ok");
  });

  socket.on("create-game", (newGame) => {
    game = JSON.parse(JSON.stringify(newGame))
    //leaderboard = JSON.parse(JSON.stringify(newLeaderboard))
    console.log("Game data is ", newGame);
    socket.join(newGame.gameId)
    console.log(
      "Host with id " + socket.id + " started game and joined room: " + newGame.gameId
    )
  })

  //username, socketId, gameId, cb
  //userInfo = [username, socketId, gameId, cb]
  socket.on("add-player", (userInfo) => {
    // let username = userInfo[0];
    // let socketId = userInfo[1];
    // let gameId = userInfo[2];
    // let cb = userInfo[3];

    // "username": usernameController.text,
    //                 "socketId": socket.id,
    //                 "gameId": gameIdController.text,

    addPlayer(userInfo.username, socket.id)
    // console.log(game._id)
    //cb("correct", username, gameId)
    socket.join(userInfo.gameId)
    console.log(
      "User " +
      userInfo.username +
      " with ID " +
      socket.id +
      " joined room " +
      userInfo.gameId
    )
    let player = getPlayer(socket.id)
    //io.emit("player-added", player)
    console.log("Player added?", player)
    //socket.emit('player-added', "ok from serverrrrrr");
    socket.emit("player-added", player)
    socket.to(userInfo.gameId).emit('player-added', player)
    //console.log("player added isssssss" + socket.in(userInfo.gameId).emit('player-added', player))
    // if (game.pin === gameId) {
    //   addPlayer(username, socketId)
    //   // console.log(game._id)
    //   cb("correct", username, gameId)
    //   socket.join(gameId)
    //   console.log(
    //     "User " +
    //     username +
    //     " with ID " +
    //     socket.id +
    //     " joined room " +
    //     gameId
    //   )
    //   let player = getPlayer(socketId)
    //   io.emit("player-added", player)
    // } else {
    //   cb("wrong", gameId)
    // }
  })

  socket.on("delete-game", (gameId) => {
    io.socketsLeave(gameId);
    console.log("Game id deleted ", gameId);
    socket.emit("delete-game", gameId);
    players = [];
  })

  socket.on('leave-game',(gameId) => {  
    try{
      console.log('[socket]','leave room :', gameId);
      socket.leave(gameId);
      socket.to(gameId).emit('user-left', socket.id);
    }catch(e){
      console.log('[error]','leave room :', e);
      socket.emit('error','couldnt perform requested action');
    }
  })
});

http.listen(PORT, () => {
  console.log('listening on *:${PORT}');
});




// io.on('connection', (socket) => {
//   console.log('a user connected');
// });

//instrument(io, { auth: false });