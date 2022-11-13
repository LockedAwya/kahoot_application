const { instrument } = require('@socket.io/admin-ui');

const app = require('express')()
const http = require('http').createServer(app)
const PORT = 3003;

const io = require("socket.io")(http)

let game;
let leaderboard;
let players = [];
let rooms = [];

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

const addPlayer = (username, roomId, socketId) => {
  !players.some((player) => player.socketId === socketId) &&
    players.push({ username, roomId, socketId })
  console.log(players);
}

const getPlayer = (socketId) => {
  return players.find((player) => player.socketId === socketId)
}

const getRoom = (roomId) => {
  return rooms.find((room) => room === roomId);
}

const checkDuplicatedUsername = (username, roomId) => {
  // for (let i = 0; i < players.length; i++) {
  //   if (players[i].gameId === roomId) {

  //   }
  // }
  let rooms_temp = rooms;
  rooms_temp.sort(dynamicSort("roomId"));
  for (let i = 0; i < rooms_temp.length; i++) {
    if (rooms_temp[i].roomId === roomId && rooms_temp[i].username === username) {
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
    rooms.push(newGame.roomId);
    socket.join(newGame.roomId)
    console.log(
      "Host with id " + socket.id + " started game and joined room: " + newGame.roomId
    )
  })

  //username, socketId, roomId, cb
  //userInfo = [username, socketId, roomId, cb]

  socket.on("join-game-validation", (userInfo) => {
    if (rooms != []) {
      let getRoomRes = getRoom(userInfo.roomId);
      console.log(getRoomRes);
      if (getRoomRes !== undefined) {
        const message = "success"
        socket.emit("join-game-validation", message);
        socket.on("add-player", (userInfo) => {
          /**
           * userInfo : { 
           * username
           * roomId
           * socketId
           * }
           */
          addPlayer(userInfo.username, userInfo.roomId, socket.id)
          socket.join(userInfo.roomId)
          console.log(
            "User " +
            userInfo.username +
            " with ID " +
            socket.id +
            " joined room " +
            userInfo.roomId
          )
          let player = getPlayer(socket.id)
          //io.emit("player-added", player)
          console.log("Player added?", player)
          //socket.emit('player-added', "ok from serverrrrrr");
          socket.emit("player-added", player)
          socket.to(userInfo.roomId).emit('player-added', player)
          //TODO: Validation check
        });
        // if (checkDuplicatedUsername(userInfo.username, userInfo.roomId) === false) {
        //   socket.on("add-player", (userInfo) => {
        //     /**
        //      * userInfo : { 
        //      * username
        //      * roomId
        //      * socketId
        //      * }
        //      */
        //     addPlayer(userInfo.username, userInfo.roomId, socket.id)
        //     socket.join(userInfo.roomId)
        //     console.log(
        //       "User " +
        //       userInfo.username +
        //       " with ID " +
        //       socket.id +
        //       " joined room " +
        //       userInfo.roomId
        //     )
        //     let player = getPlayer(socket.id)
        //     //io.emit("player-added", player)
        //     console.log("Player added?", player)
        //     //socket.emit('player-added', "ok from serverrrrrr");
        //     socket.emit("player-added", player)
        //     socket.to(userInfo.roomId).emit('player-added', player)
        //     //TODO: Validation check
        //   }
        //   )

        // } else {
        //   const message = "User with name " + userInfo.username + " already exists in room " + userInfo.roomId + ". Please try another name";
        //   socket.emit("duplicated-username", message);
        // }
      } else {
        const message = "There is no room with ID " + userInfo.roomId
        socket.emit("join-game-validation", message);
      }
    }
  })

  socket.on("delete-game", (roomId) => {
    io.socketsLeave(roomId);
    console.log("Game id deleted ", roomId);
    socket.emit("delete-game", roomId);
    players = [];
  })

  socket.on('leave-game', (userInfo) => {
    try {
      console.log('[socket]', 'leave room :', userInfo);
      socket.leave(userInfo.roomId);
      socket.to(userInfo.roomId).emit('user-left', userInfo);
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