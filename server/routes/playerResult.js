const express = require("express");
const router = express.Router();

const {
  createPlayerResult,
  getPlayerResult,
  getPlayerResults,
  addAnswer,
  //getAnswers,
  getAnswer,
  deleteAnswer,
  updateAnswer,
} = require("../controller/playerResult");

router
  .route("/")
  //.get(getPlayerResults)
  .post(createPlayerResult);

router
  .route("/:id")
  .get(getPlayerResult)
//.patch(updatePlayerResult);

router.route("/:gamePin/playerresults").get(getPlayerResults);

router
  .route("/:playerResultId/answers")
  .patch(addAnswer)

router
  .route("/:playerResultId/answers/:answerId")
  .get(getAnswer)
  .patch(updateAnswer)
  .delete(deleteAnswer);

module.exports = router;