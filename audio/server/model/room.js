const mongoose = require("mongoose");
const playerSchema = require("./player");

const roomSchema = new mongoose.Schema({
  occupancy: {
    type: Number,
    default: 2,
  },
  maxRound: {
    type: Number,
    default: 6,
  },

  currenRound: {
    require: true,
    type: Number,
    default: 1,
  },
  Players: [playerSchema],
  isjoin: {
    type: Boolean,
    default: true,
  },
  turn: playerSchema,
  turnIndex: {
    type: Number,
    default: 0,
  },
});

const roomModel = mongoose.model("Room", roomSchema);
module.exports = roomModel;
