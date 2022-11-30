const mongoose = require("mongoose")
const PlayerResult = require("../model/playerResult")
const Quiz = require("../model/quiz")
const Game = require("../model/game")

const createPlayerResult = async (req, res) => {
  const { playerName, gamePin, score, answers } = req.body
  const playerResult = new PlayerResult({
    playerName,
    gamePin,
    score,
    answers,
  })

  try {
    const newPlayerResult = await playerResult.save()
    res.status(201).json(newPlayerResult)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

const getPlayerResults = async (req, res) => {
  const { gamePin } = req.params
  try {
    const playerResults = await PlayerResult.find({ gamePin: gamePin });
    res.status(200).send(playerResults)
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

//get player result by player id

const getPlayerResult = async (req, res) => {
  let playerResult
  try {
    playerResult = await PlayerResult.findById(req.params.id)
    if (playerResult == null) {
      return res.status(404).json({ message: "Player Result not found" })
    }
    res.json(playerResult)
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

// const deletePlayerResult = async (req, res) => {
//   const { id } = req.params
//   if (!mongoose.Types.ObjectId.isValid(id)) {
//     return res.status(404).send(`No PlayerResult with id: ${id}`)
//   }

//   try {
//     await PlayerResult.findByIdAndRemove(id)
//     res.json({ message: "Player Result deleted succesfully" })
//   } catch (error) {
//     res.status(500).json({ message: error.message })
//   }
// }

// const updatePlayerResult = async (req, res) => {
//   const { id } = req.params
//   // if (!mongoose.Types.ObjectId.isValid(id)) {
//   //   return res.status(404).send(`No PlayerResult with id: ${id}`)
//   // }

//   const { playerId, gameId, score } = req.body
//   const playerResult = new PlayerResult({
//     _id: id,
//     playerId,
//     gameId,
//     score,
//   })

//   try {
//     const updatedPlayerResult = await PlayerResult.findByIdAndUpdate(
//       id,
//       playerResult,
//       { new: true }
//     )
//     res.json(updatedPlayerResult)
//   } catch (error) {
//     res.status(400).json({ message: error.message })
//   }
// }

const addAnswer = async (req, res) => {
  const { playerResultId } = req.params
  //answers is the submitted answer list from users
  /**
   * {
   * newAnswer: { 
   * quizId:
   * gameId:
   * questionIndex:
   * answer:
   * }
   * }
   */
  const {
    questionIndex,
    answerChoice,
    quizId,
    gamePin
  } = req.body


  let playerResult
  let game
  let quiz
  let correctAnswers
  // let answerTime
  // let points = 0
  try {
    playerResult = await PlayerResult.findById(playerResultId)
    //game = await Game.findOne({ gamePin: gamePin })
    quiz = await Quiz.findById(quizId)
    console.log(quiz.questionList[questionIndex - 1].answerList)
    correctAnswers = quiz.questionList[questionIndex - 1].answerList
      .filter((answer) => answer.isCorrect === true) //filter the correct answers of a quiz
      .map((answer) => ({
        name: answer.name,
        body: answer.body
      })) //answer content which is correct  (4 choices a, b, c, d)

    //answerTime = quiz.questionList[questionIndex-1].answerTime
    //points = quiz.scorePerQuestion
    console.log("Correct answer is ", correctAnswers)
    playerResult.answers.push({
      questionIndex: questionIndex,
      answer: { name: answerChoice }
      // answered: {
      //     type: Boolean,
      //     default: false
      // },
      // answer: {
      //   name: { type: String },
      //   body: { type: String }
      // },
      // correctAnswer: [{
      //   name: { type: String },
      //   body: { type: String }
      // }]
    })
    console.log("Player result answer is ", playerResult.answers[playerResult.answers.length - 1])
    if (correctAnswers[0].name === playerResult.answers[playerResult.answers.length - 1].answer.name) {
      console.log("Your answer is correct");
      playerResult.score += quiz.scorePerQuestion;
      //res.send("Your answer is correct");
      //quiz.scorePerQuestion;
    } else {
      console.log("Your answer is incorrect");
      //res.send("Your answer is incorrect");
    }
    // let sortedAnswers = answers.sort()
    // console.log(sortedAnswers);
    // // if (answered === true) {
    // if (answers.length > 0) {
    //   let answerCount = 0
    //   for (let i = 0; i < correctAnswers.length; i++) {
    //     if (correctAnswers[i] === sortedAnswers[i]) {
    //       answerCount++
    //     }
    //   }
    //   if (answerCount === correctAnswers.length) {
    //     //points = calculatePoints(quiz, time, pointType, answerTime)
    //     points += quiz.scorePerQuestion;
    //   }
    // }

    // //playerResult.score += points
    // playerResult.answers.push({
    //   questionIndex,
    //   // answered,
    //   answers,
    //   //time,
    //   correctAnswers,
    //   points,
    // })
    const updatedPlayerResult = await playerResult.save()
    console.log("Sent data", updatedPlayerResult)
    res.status(201).json(updatedPlayerResult);
    //res.send(updatedPlayerResult)
    //res.json(updatedPlayerResult);
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

// const getAnswers = async (req, res) => {
//   const { playerResultId } = req.params
//   try {
//     const playerResult = await PlayerResult.findById(playerResultId)
//     if (playerResult == null) {
//       return res.status(404).json({ message: "Player Result not found" })
//     }
//     res.status(200).send(playerResult.answers)
//   } catch (error) {
//     res.status(500).json({ message: error.message })
//   }
// }

const getAnswer = async (req, res) => {
  const { playerResultId, answerId } = req.params
  try {
    const playerResult = await PlayerResult.findById(playerResultId)
    if (playerResult == null) {
      return res.status(404).json({ message: "Player Result not found" })
    }
    const answer = playerResult.answers.id(answerId)
    res.json(answer)
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

const deleteAnswer = async (req, res) => {
  const { playerResultId, answerId } = req.params
  if (!mongoose.Types.ObjectId.isValid(playerResultId)) {
    return res.status(404).send(`No Player Result with id: ${playerResultId}`)
  }
  if (!mongoose.Types.ObjectId.isValid(answerId)) {
    return res.status(404).send(`No answer with id: ${answerId}`)
  }
  const playerResult = await PlayerResult.findById(playerResultId)

  try {
    let answerIndex = playerResult.answers.findIndex(
      (obj) => obj._id == answerId
    )
    playerResult.answers.splice(answerIndex, 1)
    playerResult.score -= playerResult.answers[answerIndex].points
    await PlayerResult.findByIdAndUpdate(playerResultId, playerResult, {
      new: true,
    })
    res.json({ message: "Answer deleted succesfully" })
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

const updateAnswer = async (req, res) => {
  const { playerResultId, answerId } = req.params
  // if (!mongoose.Types.ObjectId.isValid(playerResultId)) {
  //   return res.status(404).send(`No quiz with id: ${playerResultId}`)
  // }
  // if (!mongoose.Types.ObjectId.isValid(answerId)) {
  //   return res.status(404).send(`No question with id: ${answerId}`)
  // }

  const { questionIndex, answered, answerIndex, time } = req.body
  let playerResult
  let quiz
  let correctAnswerIndex
  let points = 0

  try {
    playerResult = await PlayerResult.findById(playerResultId)
    if (playerResult == null) {
      return res.status(404).json({ message: "Player Result not found" })
    }
    let answerPosition = playerResult.answers.findIndex(
      (obj) => obj._id == answerId
    )
    //playerResult.score -= playerResult.answers[answerPosition].points
    quiz = await Quiz.findById(playerResult.quizId)
    correctAnswerIndex = quiz.questionList[questionIndex].correctAnswer
    // if (answered && answerIndex === correctAnswerIndex) {
    //   points = calculatePoints(quiz, time)
    // }
    playerResult.score += points
    playerResult.answers[answerPosition] = {
      _id: answerId,
      questionIndex,
      answered,
      answerIndex,
      time,
    }
    const updatedPlayerResult = await PlayerResult.findByIdAndUpdate(
      playerResultId,
      playerResult,
      {
        new: true,
      }
    )
    res.send(updatedPlayerResult)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

module.exports = {
  createPlayerResult,
  getPlayerResult,
  getPlayerResults,
  //updatePlayerResult,
  addAnswer,
  //getAnswers,
  getAnswer,
  deleteAnswer,
  updateAnswer,
}
