const { instrument } = require('@socket.io/admin-ui');

const app = require('express')()
const http = require('http').createServer(app)
const PORT = 3003;

const io = require("socket.io")(http)

let game;
let leaderboard;

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

  socket.on("delete-game", (gameId) => {
    io.socketsLeave(gameId);
    console.log("Game id deleted ", gameId);
  })
});

http.listen(PORT, () => {
  console.log('listening on *:${PORT}');
});




// io.on('connection', (socket) => {
//   console.log('a user connected');
// });

//instrument(io, { auth: false });