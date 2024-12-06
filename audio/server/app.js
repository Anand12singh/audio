const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const mongoose = require("mongoose");
// Initialize express app
const app = express();
const server = http.createServer(app);
app.use(express.json());

// Initialize Socket.IO
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

// Handle client connections
io.on("connection", (socket) => {
  console.log(`Client connected: ${socket.id}`);

  // Listen for the 'message' event
  socket.on("message", (data) => {
    console.log(`Message from client ${socket.id}:`, data);
    socket.emit("serverResponse", { message: "Hello from Node.js!" });
  });

  // Listen for the 'createRoom' event
  socket.on("createRoom", ({ nickName }) => {
    console.log("Nick Name: " + nickName);
    // socket.emit("roomCreated", { roomName: `Room for ${nickName}` });
  });

  // Handle client disconnection
  socket.on("disconnect", () => {
    console.log(`Client disconnected: ${socket.id}`);
  });
});

// Connect to MongoDB
const DB =
  "mongodb+srv://singhbanand12:anand12@tictac.04nqs.mongodb.net/?retryWrites=true&w=majority&appName=Tictac";
mongoose
  .connect(DB)
  .then(() => console.log("MongoDB Connected"))
  .catch((e) => console.log(`Error connecting to MongoDB: ${e.message}`));

// Start the server
const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Socket.IO server running on http://localhost:${PORT}`);
});
