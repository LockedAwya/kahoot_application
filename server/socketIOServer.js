const { instrument } = require('@socket.io/admin-ui');

const PORT = 3003;

const io = require("socket.io")(PORT, {
  cors: {
    origin: ["http://localhost:55866", "https://admin.socket.io"]
  }
})

instrument(io, { auth: false });