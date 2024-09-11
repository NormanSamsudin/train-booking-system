const mongoose = require("mongoose");

// seat schema
const seatSchema = mongoose.Schema({
  train: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Train",
    required: true,
  },
  seatNumber: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    enum: ["available", "booked", "locked"],
    default: "available",
    required: true,
  },
  owner: {
    type: String,
    default: "",
  },
});

const Seat = mongoose.model("Seat", seatSchema);

module.exports = Seat;
