const express = require("express")
const router = express.Router()

const {
    getQuizes,
    createQuiz,
    getQuiz,
    addQuestion,
    getQuestions,
    getQuestion,
    getHostQuizes
} = require("../controller/quiz")

//get list of quizes and create a quiz
router.route("/").get(getQuizes).post(createQuiz)
//get quiz, update quiz and delete quiz by id
router.route("/:id").get(getQuiz).patch(updateQuiz).delete(deleteQuiz)
//get list of quizes by host id
router.route("/host/:hostId").get(getHostQuizes)

router.route("/:quizId/questions").get(getQuestions).post(addQuestion)
router.route("/:quizId/questions/:questionId").get(getQuestion)

module.exports = router;