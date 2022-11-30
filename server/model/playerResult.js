const mongoose = require("mongoose")

const playerResultSchema = mongoose.Schema({
    playerId: {
        type: mongoose.Schema.Types.ObjectId,
        //ref: "Game"
    },
    gamePin: {
        type: String,
        //ref: "Game"
    },
    playerName: { type: String },
    score: {
        type: Number,
        default: 0
    },
    answers: [{
        questionIndex: { type: Number },
        // answered: {
        //     type: Boolean,
        //     default: false
        // },
        answer: {
            name: { type: String },
            //body: { type: String }
        },
        // correctAnswer: {
        //     name: { type: String },
        //     body: { type: String }
        // },
        // time: {
        //     tyoe: Number
        // },
        // currentScore: {
        //     type: Number,
        //     default: 0
        // }
    }]
})
const PlayerResult = mongoose.model("PlayerResult", playerResultSchema)

module.exports = PlayerResult