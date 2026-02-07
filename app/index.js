require("dotenv").config();   // MUST be first
console.log("MONGO_URI =", process.env.MONGO_URI);

const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.error("Mongo error:", err));

app.use("/api/notes", require("./routes/notes"));

app.listen(5000, () => {
  console.log("Server running on port 3000");
});
