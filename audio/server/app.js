const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const mongoose = require("mongoose");
// Initialize express app
const app = express();
const server = http.createServer(app);
app.use(express.json());

const Room = require("./model/room");

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
  // socket.on("message", (data) => {
  //   console.log(`Message from client ${socket.id}:`, data);
  //   socket.emit("serverResponse", { message: "Hello from Node.js!" });
  // });

  // Listen for the 'createRoom' event
  socket.on("createRoom", async ({ nickName }) => {
    console.log("Nick Name: " + nickName);
    console.log(`Message from client ${socket.id}:`);

    try {
      let room = Room();
      let player = {
        socketId: socket.id,
        nickName: nickName,
        playerType: "X",
      };

      room.Players.push(player);
      room.turn = player;

      room = await room.save();
      console.log(`room check: ${room}`);
      const roomId = room._id.toString();
      console.log(`room id : ${roomId}`);

      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (error) {
      console.log(`check error ${error}`);
    }

    // socket.emit("roomCreated", { roomName: `Room for ${nickName}` });
  });

  socket.on("joinRoom", async ({ nickName, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        console.log("Invalid Room ID format");
        socket.emit(
          "error",
          "Invalid Room ID format. Please provide a valid Room ID."
        );
        return;
      }

      let room = await Room.findById(roomId);
      console.log(room.isjoin);
      if (!room) {
        console.log(`Room not found for ID: ${roomId}`);
        socket.emit("error", "Room not found. Please check the Room ID.");
        return;
      }

      if (room.isjoin) {
        const player = {
          nickName: nickName,
          socketId: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.Players.push(player);
        room.isjoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updateplayers", room.Players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        console.log("Game already in progress");
        socket.emit("error", "The game is already in progress.");
      }
    } catch (error) {
      console.error(`Error in joinRoom: ${error}`);
      socket.emit("error", "An error occurred while joining the room.");
    }
  });

  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);

      let choice = room.turn.playerType;

      if (room.turnIndex == 0) {
        room.turn = room.Players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.Players[0];
        room.turnIndex = 0;
      }

      room = await room.save();

      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (error) {
      console.log(`Error In ${error}`);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = await room.Players.find(
        (player) => player.socketId == winnerSocketId
      );

      console.log(`Winner Player ${player}`);

      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRound) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (error) {
      console.log(`Winner Error ${error}`);
    }
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
