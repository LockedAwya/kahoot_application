//const e = require('express');
const express = require('express')
const mongoose = require("mongoose")
const cors = require('cors');

const PORT = 3000;
const app = express();
const DB = "mongodb+srv://elipsical:jerry100@cluster0.p18hqnw.mongodb.net/?retryWrites=true&w=majority"
//import from files
const authRouter = require('./routes/auth')
const quizRouter = require('./routes/quiz')
const gameRouter = require('./routes/game')
const leaderboardRouter = require('./routes/leaderboard')
const playerResultRouter = require('./routes/playerResult')

app.use(cors({
    origin: '*'
}));

//middleware
app.use(express.json())
app.use(authRouter)
app.use("/api/quizes", quizRouter);
app.use("/api/games", gameRouter);
app.use("/api/leaderboard", leaderboardRouter)
app.use("/api/playerResult", playerResultRouter);

//Connection
mongoose
    .connect(DB)
    .then(() => {
        console.log("Connection Successful!")
    })
    .catch((e) => {
        console.log(e)
    })

//API
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT} hello`)
})