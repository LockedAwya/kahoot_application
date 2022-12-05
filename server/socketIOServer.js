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

const addPlayer = (username, gamePin, socketId, userId) => {
  !players.some((player) => player.socketId === socketId) &&
    players.push({ username, gamePin, socketId, userId })
  console.log(players);
}

const getPlayer = (socketId) => {
  return players.find((player) => player.socketId === socketId)
}

const getGame = (gamePin) => {
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

  socket.on("create-game", (newGame, cb) => {
    game = JSON.parse(JSON.stringify(newGame))
    //leaderboard = JSON.parse(JSON.stringify(newLeaderboard))
    console.log("Game data is ", newGame);
    games.push(newGame.gamePin);
    socket.join(newGame.gamePin)
    console.log(
      "Host with socket id " + socket.id + " started game and joined gamePin: " + newGame.gamePin
    )
    cb({
      "test1": "fsdafas",
      "test2": "dfasd"
    });
  })

  //username, socketId, gamePin, cb
  //userInfo = [username, socketId, gamePin, cb]

  socket.on("add-player", (userInfo) => {
    /**
     * userInfo : { 
     * username
     * gamePin
     * socketId
     * userId
     * }
     */
    addPlayer(userInfo.username, userInfo.gamePin, userInfo.socketId, userInfo.userId)
    socket.join(userInfo.gamePin)
    console.log(
      "User " +
      userInfo.username +
      " with ID " +
      userInfo.userId +
      " joined game " +
      userInfo.gamePin
    )
    let player = getPlayer(userInfo.socketId)
    //io.emit("player-added", player)
    console.log("Player added?", player)
    //socket.emit('player-added', "ok from serverrrrrr");
    //socket.emit("player-added", player)
    socket.to(userInfo.gamePin).emit('player-added', player)
  })

  socket.on("start-game", (gameInfo) => {
    /**
     * gameInfo {
     * quizId
     * scorePerQuestion
     * timer
     * gamePin
     * }
     */
    quiz = JSON.parse(JSON.stringify(gameInfo.quizId))
    console.log("Move players to the game")
    console.log(gameInfo.gamePin)
    let sentInfo = {
      quizId: gameInfo.quizId,
      gamePin: gameInfo.gamePin,
      scorePerQuestion: gameInfo.scorePerQuestion,
      timer: gameInfo.timer
    }
    console.log("Sent info is ", sentInfo);
    socket.to(gameInfo.gamePin).emit("move-to-gameplay", sentInfo)
    // for (let i = 0; i < players.length; i++) {
    //   if (players[i].gamePin === gameInfo.gamePin) {
    //     //tempPlayers.push(players[i]);
    //     socket.to(gameInfo.gamePin).emit("move-to-gameplay", players[i].socketId)
    //     // socket.leave(gamePin);
    //     // socket.to(gamePin).emit('game-deleted', players[i].socketId);
    //   }
    // }
  })

  socket.on("move-to-question-preview", (gameInfo) => {
    /**
     * gameInfo {
     * quizId
     * scorePerQuestion
     * timer
     * gamePin
     * }
     */
    //quiz = JSON.parse(JSON.stringify(gameInfo.quizId))
    console.log("Move players to the question preview")
    console.log(gameInfo.gamePin)
    socket.to(gameInfo.gamePin).emit("move-players-to-question-preview", {
      quizId: gameInfo.quizId,
      gamePin: gameInfo.gamePin,
      scorePerQuestion: gameInfo.scorePerQuestion,
      timer: gameInfo.timer
    })
    // for (let i = 0; i < players.length; i++) {
    //   if (players[i].gamePin === gameInfo.gamePin) {
    //     //tempPlayers.push(players[i]);
    //     socket.to(gameInfo.gamePin).emit("move-players-to-question-preview", players[i].socketId)
    //     // socket.leave(gamePin);
    //     // socket.to(gamePin).emit('game-deleted', players[i].socketId);
    //   }
    // }
  })

  socket.on("move-to-leaderboard", (leaderboardInfo) => {
    /**
     * gamePin
     * questionLeaderboard[questionLeaderboard.length - 1]
     */
    console.log("Move all people to the leaderboard")
    console.log(leaderboardInfo.gamePin);
    io.in(leaderboardInfo.gamePin).emit('move-all-to-leaderboard', {
      currentLeaderboard: leaderboardInfo.questionLeaderboard[leaderboardInfo.questionLeaderboard.length - 1].leaderboardList
    });
  })

  socket.on("delete-game", (gamePin) => {
    console.log("Game id deleted ", gamePin);
    let tempPlayers = [];
    for (let i = 0; i < players.length; i++) {
      if (players[i].gamePin === gamePin) {
        //tempPlayers.push(players[i]);
        socket.leave(gamePin);
        socket.to(gamePin).emit('game-deleted', players[i].socketId);
      }
    }
    io.socketsLeave(gamePin);
    //players = [];
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