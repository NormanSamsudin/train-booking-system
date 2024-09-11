const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const trainRouter = require("./routes/train");
const seatRouter = require("./routes/seat");


const PORT = 3000;

const app = express();

const DB =
  "mongodb://127.0.0.1:27017/train-booking?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.0";

app.use(express.json({ limit: "10kb" }));

//middleware to register route
app.use(authRouter);
app.use(trainRouter);
app.use(seatRouter);

mongoose
  .connect(DB, {})
  .then(() => {
    console.log("DB Connected...");
  })
  .catch((err) => console.log("DB LOCAL ERROR:", err));

app.listen(PORT, function() {
  console.log(`Server is running on port ${PORT}`);
});
