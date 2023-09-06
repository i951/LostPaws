require("dotenv").config();
require("./utils/firebase");
const https = require("https");
const express = require("express");
const app = express();
const cors = require("cors");

// app.use(cors());
app.use(
  cors({
    origin: "*",
    allowedHeaders: "X-Requested-With, Content-Type, auth-token",
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

const options = {
  key: process.env.KEY.replace(/\\n/g, "\n"),
  cert: process.env.CERT.replace(/\\n/g, "\n"),
};

const port = 5205;
const server = https.createServer(options, app);

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
