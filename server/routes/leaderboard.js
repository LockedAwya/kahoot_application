const express = require("express")
const router = express.Router()

const {
    createLeaderBoard,
    getLeaderBoard,
    addPlayerResult
} = require("../controller/leaderboard")

router.route("/").get(getLeaderBoard).post(createLeaderBoard)
router.route("/:leaderboardId/addPlayerResult").patch(addPlayerResult)

module.exports = router