const express = require("express");
const Train = require("../models/train");

const trainRouter = express.Router();

// 1. Add train schedule
trainRouter.post("/add-train", async (req, res) => {
  try {
    const {
      plateNumber,
      startDates,
      startLocation,
      fromLocation,
      toLocation,
    } = req.body;

    // Validate required fields
    if (
      !plateNumber ||
      !startDates ||
      !startLocation ||
      !fromLocation ||
      !toLocation
    ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Create a new train
    const newTrain = new Train({
      plateNumber,
      startDates,
      startLocation,
      fromLocation,
      toLocation,
    });

    // Save the new train to the database
    await newTrain.save();

    return res
      .status(201)
      .json({ message: "Train added successfully", train: newTrain });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Server error", error: error.message });
  }
});



module.exports = trainRouter;