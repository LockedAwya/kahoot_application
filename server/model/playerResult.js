const mongoose = require("mongoose")

const playerResultSchema = mongoose.Schema ({
    playerId: {
        type: String,
        //ref: "User"
    },
    gameId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Game"
    },
    score: {
        type: Number,
        default: 0
    },
    answer: {
        questionIndex: {type: Number},
        answered: {
            type: Boolean,
            default: false
        },
        answers: [{
            name: {type: String},
            body: {type: String}
        }],
        correctAnswer: [{
            name: {type: String},
            body: {type: String}
        }],
        time: {
            tyoe: Number
        },
        currentScore: {
            type: Number,
            default: 0
        }
    }
})
const PlayerResult = mongoose.model("PlayerResult", playerResultSchema)

module.exports = PlayerResult