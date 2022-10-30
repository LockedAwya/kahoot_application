const mongoose = require('mongoose')
const Quiz = require('../model/quiz')

const createQuiz = async (req, res) => {
    const {
        name,
        description,
        background,
        creatorId,
        creatorName,
        scorePerQuestion,
        questionList,
    } = req.body

    const quiz = new Quiz({
        name,
        description,
        background,
        creatorId,
        creatorName,
        numberOfQuestion: questionList.length,
        scorePerQuestion,
        dataCreated: new Date().toISOString,
        questionList,
    })

    try {
        const newQuiz = await quiz.save()
        console.log("Quiz is :" + req.body.creatorId);
        res.status(200).json(newQuiz)
    } catch (error) {
        res.status(400).json({ message: error.message })
    }
}

const updateQuiz = async (req, res) => {
    //const { quizId } = req.params
    const {
        name,
        description,
        background,
        creatorId,
        creatorName,
        scorePerQuestion,
        questionList,
    } = req.body
    const quiz = new Quiz({
        _id: req.params.id,
        name,
        description,
        background,
        creatorId,
        creatorName,
        scorePerQuestion,
        questionList,
    }
    )
    try {
        const quizUpdated = await Quiz.findByIdAndUpdate(req.params.id, quiz, { new: true })
        res.status(200).json(quizUpdated)
    } catch (error) {
        res.status(400).json({ message: error.message })
    }
}

const deleteQuiz = async (req, res) => {
    //const { id } = req.params;
    console.log(req.params.id)
    try {
        await Quiz.findByIdAndRemove(req.params.id);
        res.json({ message: "Quiz has deleted." })
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const getQuizes = async (req, res) => {
    try {
        const quizes = await Quiz.find()
        res.status(200).send(quizes)
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const getHostQuizes = async (req, res) => {
    let hostId = req.params.hostId
    try {
        const quizes = await Quiz.find({ creatorId: hostId })
        res.status(200).send(quizes)
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const getQuiz = async (req, res) => {
    let quiz;
    try {
        quiz = await Quiz.findById(req.params.id)
        if (quiz == null) {
            return res.status(404).json({
                msg: "Quiz not found!"
            })
        }
        res.status(200).json(quiz)
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const addQuestion = async (req, res) => {
    const {
        questionType,
        scoreType,
        timer,
        question,
        answerList,
        correctAnswerList
    } = req.body

    let quiz;
    try {
        quiz = await Quiz.findById(req.params)
        if (quiz == null) {
            return res.status(404).json({
                msg: "Quiz not found!"
            })
        }
        quiz.questionList.push({
            questionType,
            scoreType,
            timer,
            question,
            answerList,
            correctAnswerList
        })
        quiz.numberOfQuestion += 1
        const updateQuiz = await quiz.save()
        res.status(201).json(updateQuiz)
    } catch (error) {
        res.status(400).json({ message: error.message })
    }
}

const getQuestions = async (req, res) => {
    try {
        const quiz = await Quiz.findById(req.params)
        if (quiz == null) {
            return res.status(404).json({
                msg: "Quiz not found!"
            })
        }
        res.status(200).send(quiz.questionList);
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

const getQuestion = async (req, res) => {
    const { quizId, questionId } = req.params
    try {
        const quiz = await Quiz.findById(quizId)
        if (quiz == null) {
            return res.status(404).json({
                msg: "Quiz not found!"
            })
        }
        const question = quiz.questionList.id(questionId)
        res.json(question)
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

module.exports = {
    createQuiz,
    getQuizes,
    getQuiz,
    addQuestion,
    getQuestions,
    getQuestion,
    getHostQuizes,
    updateQuiz,
    deleteQuiz
}