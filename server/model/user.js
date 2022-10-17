<<<<<<< HEAD
const mongoose = require('mongoose')

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        validate: {
            validator: (value) => {
                const reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                return value.match(reg);
            },
            message: "Enter a vaild email address."
        }
    },
    username: {
        type: String,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true
    }
})

const User = mongoose.model("User", userSchema)

=======
const mongoose = require('mongoose')

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        validate: {
            validator: (value) => {
                const reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                return value.match(reg);
            },
            message: "Enter a vaild email address."
        }
    },
    username: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    }
})

const User = mongoose.model("User", userSchema)

>>>>>>> b630b0a2d43832e08c102e6c2e3afe1f97a31285
module.exports = User