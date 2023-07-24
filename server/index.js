require("dotenv").config();
const http = require("http");
const express = require("express");
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const port = 5205;
const server = http.createServer(app);

// Routes
const userRouter = require("./routes/user.route.js");
const postRouter = require("./routes/post.route.js");

app.use("/users", userRouter);
app.use("/posts", postRouter);

// Connect to database and start server
const mongooseSetup = require("./utils/mongoose.js");
mongooseSetup
  .dbconnect()
  .once("open", () => {
    console.log("MongoDB connected!");
    server.listen(port);
  })
  .on("error", (err) => console.log("Error connecting to MongoDB!"));

server.on("listening", () => {
  console.log("Server listening on port", port);
});

app.get("/", (req, res) => {
  res.send("ʕ ·(エ)· ʔ");
});

module.exports = app;
