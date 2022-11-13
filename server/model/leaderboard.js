const mongoose = require("mongoose")

const leaderBoardSchema = new mongoose.Schema({
  gameId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Game",
  },
  playerResultList: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "PlayerResult",
    },
  ],
  questionLeaderboard: [
    {
      questionIndex: { type: Number },
      questionResultList: [
        {
          playerName: {
            type: String,
          },
          playerPoints: { type: Number },
        },
      ],
    },
  ],
  currentLeaderboard: [
    {
      questionIndex: { type: Number },
      leaderboardList: [
        {
          playerName: {
            type: String,
          },
          playerCurrentScore: { type: Number },
        },
      ],
    },
  ],
})

module.exports = mongoose.model("Leaderboard", leaderBoardSchema)
