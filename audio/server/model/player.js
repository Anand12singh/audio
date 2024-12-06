const mongoose = require("mongoose");

const playerSchema = mongoose.Schema({
  nickName: {
    type: String,
    trim: true,
    socketId: {
      type: String,
    },
  },
  points: {
    type: Number,
    default: 0,
  },

  playerType: {
    type: String,

    require: true,
  },
});

module.exports = playerSchema;
