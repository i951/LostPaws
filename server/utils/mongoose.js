require("dotenv").config();
const mongoose = require("mongoose");
const uri = process.env.MONGODB_URI;
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
