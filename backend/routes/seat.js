const express = require("express");
const Seat = require("../models/seat");

const seatRouter = express.Router();

// get list of seat based on plateNumber
seatRouter.get("/api/seat/:id/:coach", async (req, res) => {
  try {
    const coachLetter = req.params.coach;
    const availableSeats = await Seat.find({
      train: req.params.id,
      seatNumber: { $regex: new RegExp(`^${coachLetter}`, "i") }, // Dynamically insert the coach letter
    });
    res.status(200).json(availableSeats);
  } catch (error) {
    return res.status(400).json({ msg: "Error fetching seat" });
  }
});

//Book a seat
seatRouter.patch("/api/seat/book-seat", async (req, res) => {
  const { seatNumber, owner, train } = req.body;

  try {
    const seat = await Seat.findOne({
      train: train,
      seatNumber: seatNumber,
    });

    if (!seat) {
      return res
        .status(404)
        .json({ message: "Seat not available for booking" });
    }

    // Update seat status to "booked"
    seat.status = "booked";
    seat.owner = owner;
    await seat.save();

    res.status(200).json({ message: "Seat successfully booked", seat });
  } catch (error) {
    res.status(500).json({ message: "Error booking seat", error });
  }
});

// lock seat
seatRouter.patch("/api/seat/lock-seat", async (req, res) => {
  const { seatNumber, train } = req.body;

  try {
    const seat = await Seat.findOne({
      train: train,
      seatNumber: seatNumber,
      status: "available",
    });

    if (!seat) {
      return res
        .status(404)
        .json({ message: "Seat not available for booking" });
    }

    // Update seat status to "booked"
    seat.status = "locked";
    await seat.save();

    res.status(200).json({ message: "Seat locked", seat });
  } catch (error) {
    res.status(500).json({ message: "Error booking seat", error });
  }
});

seatRouter.patch("/api/seat/unlock-seat", async (req, res) => {
  const { seatNumber, train } = req.body;

  try {
    const seat = await Seat.findOne({
      train: train,
      seatNumber: seatNumber,
      status: "locked",
    });

    if (!seat) {
      return res
        .status(404)
        .json({ message: "Seat not available for booking" });
    }

    // Update seat status to "booked"
    seat.status = "available";
    await seat.save();

    res.status(200).json({ message: "Seat locked", seat });
  } catch (error) {
    res.status(500).json({ message: "Error booking seat", error });
  }
});

// Add seat for a train
seatRouter.post("/api/seat/add-seat/:train", async (req, res) => {
  try {
    const { seatNumber, status } = req.body;
    const train = req.params.train;

    // Validate required fields
    if (!train || !seatNumber || !status) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Check if the plateNumber is unique
    const existingSeat = await Seat.findOne({ seatNumber });
    if (existingSeat) {
      return res.status(400).json({ message: "Seat already exists" });
    }

    const newSeat = new Seat({
      train,
      seatNumber,
      status,
    });

    // Save the new train schedule to the database
    await newSeat.save();

    return res
      .status(201)
      .json({ message: "Seat added successfully", seat: newSeat });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Server error", error: error.message });
  }
});

module.exports = seatRouter;
