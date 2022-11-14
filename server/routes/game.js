const express = require("express")
const router = express.Router()

const {
    createGame,
    getGames,
    getGame,
    addPlayer
} = require("../controller/game")

router.route("/").get(getGames).post(createGame)
router.route("/:gameId/addPlayer").patch(addPlayer)
router.route("/:gameId").get(getGame)

module.exports = router