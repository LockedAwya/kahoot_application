const mongoose = require("mongoose")
const Leaderboard = require("../model/leaderboard")
const Quiz = require("../model/quiz")
const Game = require("../model/game")
const PlayerResult = require("../model/playerResult");

const createLeaderboard = async (req, res) => {
  const { gameId, gamePin, questionLeaderboard } = req.body

  //let quiz = await Quiz.findById(game.quizId)
  //let game = await Game.findById(gameId)

  const leaderboard = new Leaderboard({
    gameId,
    gamePin,
    questionLeaderboard,
  })

  // quiz.questionList.forEach((question, index) => {
  //   leaderboard.questionLeaderboard.push({
  //     questionIndex: index + 1,
  //     questionResultList: [],
  //   })
  //   // leaderboard.currentLeaderboard.push({
  //   //   questionIndex: question.questionIndex,
  //   //   leaderboardList: [],
  //   // })
  // })

  try {
    const newLeaderboard = await leaderboard.save()
    res.status(201).json(newLeaderboard)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

const getLeaderboard = async (req, res) => {
  let leaderboard
  try {
    leaderboard = await Leaderboard.findById(req.params.id)
    if (leaderboard == null) {
      return res.status(404).json({ message: "Leaderboard not found" })
    }
    res.json(leaderboard)
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

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
    var result = (a[property] < b[property]) ? 1 : (a[property] > b[property]) ? -1 : 0;
    return result * sortOrder;
  }
}

const updateLeaderBoard = async (req, res) => {
  const { leaderboardId } = req.params
  /**
   * gamePin
   * questionIndex
   **/
  const { gamePin, questionIndex } = req.body
  let leaderboard
  let playerResultList

  try {
    leaderboard = await Leaderboard.findById(leaderboardId)
    playerResultList = await PlayerResult.find({ gamePin: gamePin })
    leaderboard.questionLeaderboard.push({
      questionIndex: questionIndex,
      leaderboardList: [],
    })
    let lastIndex = leaderboard.questionLeaderboard.length - 1
    for (let i = 0; i < playerResultList.length; i++) {
      leaderboard.questionLeaderboard[lastIndex].leaderboardList.push({
        playerName: playerResultList[i].playerName,
        playerPoints: playerResultList[i].score,
      });
    }
    leaderboard.questionLeaderboard[lastIndex]
      .leaderboardList.sort(dynamicSort("playerPoints"));
    const newLeaderboard = await leaderboard.save()
    res.status(201).json(newLeaderboard)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}


// const updateQuestionLeaderboard = async (req, res) => {
//   const { leaderboardId } = req.params
//   const { questionIndex, playerId, playerPoints } = req.body
//   let leaderboard

//   try {
//     leaderboard = await Leaderboard.findById(leaderboardId)
//     leaderboard.questionLeaderboard[questionIndex - 1].questionResultList.push({
//       playerId,
//       playerPoints,
//     })

//     const newLeaderboard = await leaderboard.save()
//     res.status(201).json(newLeaderboard)
//   } catch (error) {
//     res.status(400).json({ message: error.message })
//   }
// }

// const updateCurrentLeaderboard = async (req, res) => {
//   const { leaderboardId } = req.params
//   const { questionIndex, playerId, playerCurrentScore } = req.body
//   let leaderboard

//   try {
//     leaderboard = await Leaderboard.findById(leaderboardId)
//     leaderboard.currentLeaderboard[questionIndex - 1].leaderboardList.push({
//       playerId,
//       playerCurrentScore,
//     })

//     const newLeaderboard = await leaderboard.save()
//     res.status(201).json(newLeaderboard)
//   } catch (error) {
//     res.status(400).json({ message: error.message })
//   }
// }

module.exports = {
  createLeaderboard,
  getLeaderboard,
  //addPlayerResult,
  updateLeaderBoard
  //updateQuestionLeaderboard,
  //updateCurrentLeaderboard,
}
