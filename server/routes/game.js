const express = require("express")
const router = express.Router()

const {
  createGame, getGame, deleteGame, updateGame, addPlayer
} = require("../controller/game")

router
  .route("/")
  //  .get(getGames)
  .post(createGame)

router
  .route("/:gamePin/players")
  .patch(addPlayer)

router
  .route("/:id")
  .get(getGame)
  .patch(updateGame)
  .delete(deleteGame)

//router.route("/:gamePin").get(getGame).patch(updateGame).delete(deleteGame)

module.exports = router
