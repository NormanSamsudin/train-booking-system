const express = require("express");
const Train = require("../models/train");

const trainRouter = express.Router();

// 1. Add train schedule
trainRouter.post("/api/train/add-train-schedule", async (req, res) => {
  try {
    const {
      plateNumber,
      startDateTime,
      waitingGate,
      fromLocation,
      toLocation,
    } = req.body;

    // Validate required fields
    if (
      !plateNumber ||
      !startDateTime ||
      !waitingGate ||
      !fromLocation ||
      !toLocation
    ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Check if the plateNumber is unique
    const existingTrain = await Train.findOne({ plateNumber });
    if (existingTrain) {
      return res
        .status(400)
        .json({ message: "Train with this plate number already exists" });
    }

    // Create a new train schedule
    const newTrain = new Train({
      plateNumber,
      startDateTime: new Date(startDateTime), // Ensure the date is in proper format
      waitingGate,
      fromLocation,
      toLocation,
    });

    // Save the new train schedule to the database
    await newTrain.save();

    return res
      .status(201)
      .json({ message: "Train schedule added successfully", train: newTrain });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Server error", error: error.message });
  }
});
// trainRouter.post("/api/train/add-train-schedule", async (req, res) => {
//   try {
//     const {
//       plateNumber,
//       startDateTime,
//       waitingGate,
//       fromLocation,
//       toLocation,
//     } = req.body;

//     // Validate required fields
//     if (
//       !plateNumber ||
//       !startDateTime ||
//       !waitingGate ||
//       !fromLocation ||
//       !toLocation
//     ) {
//       return res.status(400).json({ message: "All fields are required" });
//     }

//     // Create a new train
//     const newTrain = new Train({
//       plateNumber,
//       startDateTime,
//       waitingGate,
//       fromLocation,
//       toLocation,
//     });

//     // Save the new train to the database
//     await newTrain.save();

//     return res
//       .status(201)
//       .json({ message: "Train added successfully", train: newTrain });
//   } catch (error) {
//     return res
//       .status(500)
//       .json({ message: "Server error", error: error.message });
//   }
// });

// 2. Get all train schedules
trainRouter.get("/api/train", async (req, res) => {
  try {
    const train = await Train.find({});
    return res.status(200).send(train);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = trainRouter;