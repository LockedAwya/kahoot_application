const mongoose = require("mongoose")

const leaderBoardSchema = new mongoose.Schema({
    gameId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Game"
    },
    playerResultList: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "PlayerResult"
    },
    questionLeaderboard: [{
        questionIndex: {
            type: Number,
        },
        questionResultList: [{
            playerId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "User"
            },
            playerScore: {
                type: Number,
            }
        }]
    }],
    currentLeaderboard: [{
        questionIndex: {
            type: Number,
        },
        leaderboard: [{
            playerId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "User"
            },
            playerCurrentScore: {
                type: Number,
            }
        }]
    }]
})

const Leaderboard = mongoose.model("Leaderboard", leaderBoardSchema)

module.exports = Leaderboard