const mongoose = require("mongoose")
const LeaderBoard = require('../model/leaderboard')
const Quiz = require('../model/quiz')
const Game = require('../model/game')

const createLeaderBoard = async(req, res) => {
    const {gameId, playerResultList} = req.body

    const leaderboard = new LeaderBoard ({gameId, playerResultList})

    var game = await Game.findById(gameId)
    var quiz = await Quiz.findById(game.quizId)

    quiz.questionList.array.forEach(question => {
        leaderboard.questionLeaderboard.push({
            questionIndex: question.questionIndex,
            questionResultList: []
        })
        leaderboard.currentLeaderboard.push({
            questionIndex: question.questionIndex,
            leaderboard: []
        })
    });

    try{
        const newLeaderBoard = await leaderboard.save()
        res.status(201).json(newLeaderBoard)
    }catch{
        res.status(400).json({ message: error.message })
    }
}

const getLeaderBoard = async (req, res) => {
    var leaderboard
    try{
        leaderboard = await LeaderBoard.findById(req.params.id)
        const getLeaderBoard = await leaderboard.find()
        res.status(200).json(getLeaderBoard)
    }catch{
        res.status(500).json({ message: error.message })
    }
}

const addPlayerResult = async (req, res) => {
    var leaderboard
    try {
        leaderboard = await LeaderBoard.findById(req.params.id)
        leaderboard.playerResultList.push(req.body)
        const newLeaderBoard = await leaderboard.save()
        res.status(201).json(newLeaderBoard)
    }catch {
        res.status(400).json({ message: error.message })
    }
}

module.exports = {
    createLeaderBoard,
    getLeaderBoard,
    addPlayerResult
}