const { instrument } = require('@socket.io/admin-ui');

const app = require('express')()
const http = require('http').createServer(app)
const PORT = 3003;

const io = require("socket.io")(http)

let game;
let leaderboard;
let players = [];
let games = [];

//https://stackoverflow.com/questions/1129216/sort-array-of-objects-by-string-property-value
function dynamicSort(property) {
  var sortOrder = 1;
  if (property[0] === "-") {
    sortOrder = -1;
    property = property.substr(1);
  }
  return function (a, b) {
    /* next line works with strings and numbers, 
     * and you may want to customize it to your needs
     */
    var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
    return result * sortOrder;
  }
}

const addPlayer = (username, gamePin, socketId) => {
  !players.some((player) => player.socketId === socketId) &&
    players.push({ username, gamePin, socketId })
  console.log(players);
}

const getPlayer = (socketId) => {
  return players.find((player) => player.socketId === socketId)
}

const getRoom = (gamePin) => {
  return games.find((game) => game === gamePin);
}

const checkDuplicatedUsername = (username, gamePin) => {
  // for (let i = 0; i < players.length; i++) {
  //   if (players[i].gamePin === gamePin) {

  //   }
  // }
  let games_temp = games;
  games_temp.sort(dynamicSort("game"));
  for (let i = 0; i < games_temp.length; i++) {
    if (games_temp[i].game === gamePin && games_temp[i].username === username) {
      return true;
    }
  }
  return false;
}
io.on("connection", (socket) => {
  console.log('a user connected with socket id ', socket.id);
  socket.on("disconnect", () => {
    console.log(socket.id + " was disconnected")
    //socket.destroy();
    //console.log(error)
  })
  // socket.on('msg', (data) => {
  //   console.log('data from default ', data);
  //   socket.emit('fromServer', "ok");
  // });

  // socket.on('lmao', (data, ack) => {
  //   console.log("Lmao data ", data);
  //   ack('test1234')
  // })

  socket.on("create-game", (newGame) => {
    game = JSON.parse(JSON.stringify(newGame))
    //leaderboard = JSON.parse(JSON.stringify(newLeaderboard))
    console.log("Game data is ", newGame);
    games.push(newGame.gamePin);
    socket.join(newGame.gamePin)
    console.log(
      "Host with id " + socket.id + " started game and joined gamePin: " + newGame.gamePin
    )
  })

  //username, socketId, gamePin, cb
  //userInfo = [username, socketId, gamePin, cb]

  socket.on("join-game-validation", (userInfo) => {
    if (games != []) {
      let getRoomRes = getRoom(userInfo.gamePin);
      console.log(getRoomRes);
      if (getRoomRes !== undefined) {
        const message = "success"
        socket.emit("join-game-validation", message);
        socket.on("add-player", (userInfo) => {
          /**
           * userInfo : { 
           * username
           * gamePin
           * socketId
           * }
           */
          addPlayer(userInfo.username, userInfo.gamePin, socket.id)
          socket.join(userInfo.gamePin)
          console.log(
            "User " +
            userInfo.username +
            " with ID " +
            socket.id +
            " joined game " +
            userInfo.gamePin
          )
          let player = getPlayer(socket.id)
          //io.emit("player-added", player)
          console.log("Player added?", player)
          //socket.emit('player-added', "ok from serverrrrrr");
          socket.emit("player-added", player)
          socket.to(userInfo.gamePin).emit('player-added', player)
          //TODO: Validation check
        });
        // if (checkDuplicatedUsername(userInfo.username, userInfo.gamePin) === false) {
        //   socket.on("add-player", (userInfo) => {
        //     /**
        //      * userInfo : { 
        //      * username
        //      * gamePin
        //      * socketId
        //      * }
        //      */
        //     addPlayer(userInfo.username, userInfo.gamePin, socket.id)
        //     socket.join(userInfo.gamePin)
        //     console.log(
        //       "User " +
        //       userInfo.username +
        //       " with ID " +
        //       socket.id +
        //       " joined room " +
        //       userInfo.gamePin
        //     )
        //     let player = getPlayer(socket.id)
        //     //io.emit("player-added", player)
        //     console.log("Player added?", player)
        //     //socket.emit('player-added', "ok from serverrrrrr");
        //     socket.emit("player-added", player)
        //     socket.to(userInfo.gamePin).emit('player-added', player)
        //     //TODO: Validation check
        //   }
        //   )

        // } else {
        //   const message = "User with name " + userInfo.username + " already exists in room " + userInfo.gamePin + ". Please try another name";
        //   socket.emit("duplicated-username", message);
        // }
      } else {
        const message = "There is no room with ID " + userInfo.gamePin
        socket.emit("join-game-validation", message);
      }
    }
  })

  socket.on("delete-game", (gamePin) => {
    io.socketsLeave(gamePin);
    console.log("Game id deleted ", gamePin);
    socket.emit("delete-game", gamePin);
    players = [];
  })

  socket.on('leave-game', (userInfo) => {
    try {
      console.log('[socket]', 'leave room :', userInfo);
      socket.leave(userInfo.gamePin);
      socket.to(userInfo.gamePin).emit('user-left', userInfo);
    } catch (e) {
      console.log('[error]', 'leave room :', e);
      socket.emit('error', 'couldnt perform requested action');
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