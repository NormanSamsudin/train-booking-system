const mongoose = require("mongoose");

// Train schema
const trainSchema = mongoose.Schema({
  plateNumber: {
    type: String,
    required: true,
  },
  startDates: {
    type: [Date],
    required: true,
  },
  startLocation: {
    type: String,
    required: true,
  },
  fromLocation: {
    type: String,
    required: true,
  },
  toLocation: {
    type: String,
    required: true,
  },
});

const Train = mongoose.model("Train", trainSchema);
module.exports = Train;
