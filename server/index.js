require("dotenv").config();
const http = require("http");
const express = require("express");
const mongoose = require("mongoose");

// // Routes
// const userRouter = require("./routes/user.route.js");
// const postRouter = require("./routes/post.route.js");

// MongoDB
const uri = `mongodb+srv://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@cluster0.qafmunu.mongodb.net/?retryWrites=true&w=majority`;
mongoose.set("strictQuery", false);

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// app.use("/users", userRouter);
// app.use("/posts", postRouter);

const port = 5205;
const server = http.createServer(app);

// Connect to database and start server
const mongooseConnect = require("./utils/mongoose.js");
mongooseConnect
  .dbconnect()
  .once("open", () => {
    console.log("MongoDB connected!")
    server.listen(port);
  })
  .on("error", (err) => console.log("Error connecting to MongoDB!"));
// mongoose
//   .connect(uri, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   })
//   .then(
//     () => {
//       console.log("MongoDB connected");
//       server.listen(port);
//     },
//     (err) => {
//       console.log("Could not connect to MongoDB");
//     }
//   );

// Routes
const userRouter = require("./routes/user.route.js");
const postRouter = require("./routes/post.route.js");

app.use("/users", userRouter);
app.use("/posts", postRouter);

// server.listen(port);
server.on("listening", () => {
  console.log("Server listening on port", port);
});

app.get("/", (req, res) => {
  res.send("ʕ ·(エ)· ʔ");
});

module.exports = app;
