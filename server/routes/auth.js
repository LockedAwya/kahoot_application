const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken")

authRouter.post("/api/signup", async (req, res) => {
    try {
        //const { name, email, username, password } = req.body;
        const { email, username, password } = req.body;

        const existUser = await User.findOne({ email })
        if (existUser) {
            return res.status(400).json({
                msg: "Email already exists!"
            })
        }

        const hashedPassword = await bcryptjs.hash(password, 8)

        let user = new User({
            //name,
            email,
            username,
            password: hashedPassword,
        })

        user = await user.save();
        return res.status(200).json(user);
    } catch (e) {
        res.status(500).json({
            error: e.message
        })
    }

})

authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email })
        if (!user) {
            return res.status(400).json({
                msg: "Email does not exist!"
            })
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({
                msg: "Incorrect Password!"
            })
        }

        const token = jwt.sign({ id: user._id }, "passwordKey")
        return res.status(200).json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({
            error: e.message
        })
    }

})

authRouter.get("/", (req, res) => {
    res.json({
        name: "DManh"
    });
})

module.exports = authRouter