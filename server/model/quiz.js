const mongoose = require("mongoose")

const quizSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    description: {
        type: String
    },
    background: {
        type: String
    },
    creatorId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    creatorName: {
        type: String,
        required: true
    },
    numberOfQuestion: {
        type: Number,
        default: 0
    },
    scorePerQuestion: {
        type: Number,
        min: 10
    },
    dateCreated: {
        type: Date,
        default: new Date()
    },
    questionList: [{
        questionType: {
            type: String,
            enum: ["True/False", "Quiz"],
            required: true,
        },

        scoreType: {
            type: String,
            enum: ["Basic", "Double"],
            required: true,
        },
        timer: {
            type: String,
            min: 10,
            max: 30,
            required: true,
        },
        backgroundQuestion: {
            type: String,
        },
        question: {
            type: String,
            required: true
        },
        answerList: [{
            name: {type: String},
            body: {type: String},
            isCorrect: {type: Boolean},
        }],
        correctAnswerList: [{
            name: {type: String},
            body: {type: String},
        }],
        questionIndex: {
            type: Number,
            required: true
        }
    }]
})

const Quiz = mongoose.model("Quiz", quizSchema)

module.exports = Quiz