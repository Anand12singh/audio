const express = require("express");

const mongoose = require("mongoose");
const { env } = require("process");

const app = express();
const port = process.env.PORT || 3000;
const hostname = "0.0.0.0";
const http = require("http");
var server = http.createServer(app);
var Socket = require("socket.io");
app.use(express.json());

var io = Socket(server);
// console.log(io);

io.on("connection", (socket) => {
  console.log("connected!");
  socket.on("createRoom", ({ nickName }) => {
    console.log(`nick Name: ${nickName}`);
  });
  socket.on("disconnect", () => {
    console.log("Client disconnected");
  });
});

const DB =
  "mongodb+srv://singhbanand12:anand12@tictac.04nqs.mongodb.net/?retryWrites=true&w=majority&appName=Tictac";

mongoose
  .connect(DB)
  .then(() => {
    console.log("MongoDB Connected");
  })
  .catch((e) => console.log(`Error connecting to MongoDB: ${e.message}`));

server.listen(port, "0.0.0.0", () => {
  console.log(`Server running on http://${hostname}:${port}`);
});
