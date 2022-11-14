const mongoose = require('mongoose')
const Game = require('../model/game')

const createGame = async(req, res) => {
    const {quizId, pin, playerList, playerResult} = req.body
    const game = new Game ({
        hostId: req.user.id,
        quizId,
        pin,
        playerList,
        playerResult
    })
}

try {
    const newGame = await game.save()
    res.status(201).json(newGame)
}catch {
    res.status(400).json({ message: error.message })
}

const getGames = async(req, res) => {
    try{
        const games = await Game.find()
        res.status(200).send(games)
    }catch {
        res.status(500).json({ message: error.message })
    }
}

const getGame = async(req, res) => {
    let game
    try {
        game = await Game.findById(req.param.id)
        if (game == null) {
            return res.status(404).json({
                msg: "Game not found!"
            })
        }
        res.status(200).json(game)
    }catch {
        res.status(500).json({ message: error.message })
    }
}

const addPlayer = async(req, res) => {
    const gameId = req.params
    const playerId = req.body

    let game
    try {
        game = await Game.findById(gameId)
        game.playerList.push(playerId)
    }catch {
        res.status(400).json({ message: error.message })
    }
}

module.exports = {
    createGame,
    getGames,
    getGame,
    addPlayer
}