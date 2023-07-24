require("dotenv").config();
const mongoose = require("mongoose");
// const uri = process.env.MONGODB_URI;
const uri = `mongodb+srv://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@cluster0.qafmunu.mongodb.net/?retryWrites=true&w=majority`;
mongoose.set("strictQuery", false);

function dbconnect() {
  mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
  return mongoose.connection;
}

function dbclose() {
  return mongoose.disconnect();
}

module.exports = { dbconnect, dbclose };
