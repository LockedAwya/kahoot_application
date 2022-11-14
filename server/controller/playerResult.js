const mongoose = require("mongoose")
const PlayerResult = require('../model/playerResult')
const Quiz = require('../model/quiz')
const Game = require('../model/game')

const createPlayerResult = async (req, res) => {
    const {playerId, gameId, score, answer} = req.body

    const playerResult = new PlayerResult ({
        playerId,
        gameId,
        score,
        answer
    })
    
    try {
        const newPlayerResult = await playerResult.save()
        res.status(201).json(newPlayerResult)
    }catch(error) {
        res.status(400).json({ message: error.message })
    }
}

const getPlayerResults = async (req, res) => {
    try{
        const playerResults = await PlayerResult.find()
        res.status(200).send(playerResults)
    }catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const getPlayerResult = async (req, res) => {
    let playerResult;
    try {
        playerResult = await PlayerResult.findById(req.params.id)
        if (playerResult == null) {
            return res.status(404).json({
                msg: "Quiz not found!"
            })
        }
        res.status(200).json(playerResult)
    }catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const addAnswer = async (req, res) => {
    const playerResultId = req.params
    const {
        questionIndex,
        answered,
        answer,
        time
    } = req.body.newAnswer

    let playerResult
    let game
    let quiz
    let correctAnswer
    let questionType
    let scoreType
    let timer
    let scores = 0

    try {
        playerResult = await PlayerResult.findById(playerResultId)
        game = await Game.findById(playerResult.gameId)
        quiz = await Quiz.findById(game.quizId)
        
        correctAnswer = quiz.questionList[questionIndex - 1].answerList.filter((answer) => answer.isCorrect == true).map((answer) => answer.name)
        scoreType = quiz.questionList[questionIndex - 1].scoreType
        timer = quiz.questionList[questionIndex - 1].timer

        let allAnswers = answer.sort()
        if(answer.length > 0) {
            let a = 0;
            for(let i = 0;i < correctAnswer.length;i++) {
                if(correctAnswer[i] === allAnswers[i]) a++
            }
            if (a === correctAnswer.length) {
                scores = scoreCalculatior(quiz, time, questionType, timer)
            }
        }
        playerResult.score += scores
        playerResult.answer.push({
            questionIndex,
            answered,
            a
        })
    }catch {

    }
}

const scoreCalculatior = (quiz, time, questionType, timer) => {
    let scorePerQuestion = quiz.scorePerQuestion

    if(questionType = "BaseOnTime") {
        return (scorePerQuestion / timer) * (timer - time)
    }
    else {
        return scorePerQuestion
    }
}