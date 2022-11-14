const express = require("express")
const router = express.Router()

const { 
    getQuizes, 
    createQuiz,
    getQuiz,
    addQuestion,
    getQuestions,
    getQuestion
} = require("../controller/quiz")

router.route("/").get(getQuizes).post(createQuiz)
router.route("/:id").get(getQuiz)
router.route("/:quizId/questions").get(getQuestions).post(addQuestion)
router.route("/:quizId/questions/:questionId").get(getQuestion)

module.exports = router