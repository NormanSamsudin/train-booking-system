const mongoose = require("mongoose");

// Train schema
const trainSchema = mongoose.Schema({
  plateNumber: {
    type: String,
    required: true,
    unique: true,
  },
  startDateTime: {
    type: Date,
    required: true,
  },
  waitingGate: {
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
  price: {
    type:String,
    required: true,
  }
});

const Train = mongoose.model("Train", trainSchema);
module.exports = Train;


// {
//   "plateNumber": "A123",
//   "startDates": "2024-09-10",
//   "fromLocation": "Station A",
//   "toLocation": "City B",
//   "waitingGate" : "11"
// }