const mongoose = require("mongoose")

const gameSchema = mongoose.Schema({
    hostId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    quizId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Quiz"
    },
    pin: {
        type: String
    },
    playerList: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    }],
    date: {
        type: Date,
        required: true,
        default: Date.now
    },
    playerResult: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "PlayerResult"
    }]
})

const Game = mongoose.model("Game", gameSchema)

module.exports = Game
