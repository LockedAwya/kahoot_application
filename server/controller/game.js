const mongoose = require("mongoose")
const Game = require("../model/game")
const PlayerResult = require("../model/playerResult")


const createGame = async (req, res) => {
  /**
   * hostId
   * quizId
   * playerList
   * playerResultList
   * pin
   */
  const { hostId, quizId, pin, playerList, playerResultList } = req.body

  const newGame = new Game({
    hostId,
    quizId,
    date: new Date().toISOString(),
    pin,
    playerList,
    playerResultList
  })

  try {
    const saveNewGame = await newGame.save()
    res.status(201).json(saveNewGame)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

const getGame = async (req, res) => {
  try {
    const game = await Game.findOne(req.params.gamePin).exec();
    if (game == null) {
      return res.status(404).json({ message: "Cannot find the game!" })
    }
    res.json(game);
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

const deleteGame = async (req, res) => {
  const { id } = req.params
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(404).send('There is no game with id: ${id}')
  }

  try {
    await Game.findByIdAndRemove(id)
    res.json({ message: "Game removed succesfully" })
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}

const updateGame = async (req, res) => {
  const { id } = req.params
  // if (!mongoose.Types.ObjectId.isValid(id)) {
  //   return res.status(404).send(`No game with id: ${id}`)
  // }

  const { hostId, quizId, pin, playerList } = req.body

  const playerResultList = await PlayerResult.find({ gameId: id })
  console.log(playerResultList)
  const game = new Game({
    _id: id,
    hostId,
    quizId,
    pin,
    playerList,
    playerResultList,
  })

  try {
    const updatedGame = await Game.findByIdAndUpdate(id, game, { new: true })
    res.json(updatedGame)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

const addPlayer = async (req, res) => {
  const { gameId } = req.params
  const { playerId, playerName } = req.body

  let game
  try {
    game = await Game.findById(gameId)
    game.playerList.push({ playerId, playerName })
    const updatedGame = await game.save()
    res.send(updatedGame)
  } catch (error) {
    res.status(400).json({ message: error.message })
  }
}

module.exports = { createGame, getGame, deleteGame, updateGame, addPlayer }
