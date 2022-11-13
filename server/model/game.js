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
        type: String,
        unique: true,
    },
    playerList: [{
        //the socket connection id will be playerId
        playerId: { type: String, unique: true },
        playerName: { type: String, unique: true },
    }],
    date: {
        type: Date,
        required: true,
        default: Date.now
    },
    playerResultList: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "PlayerResult"
    }]
})

const Game = mongoose.model("Game", gameSchema)

module.exports = Game
