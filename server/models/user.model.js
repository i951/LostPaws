const mongoose = require("mongoose");

const userSchema = mongoose.Schema(
  {
    username: {
      type: String,
      unique: true,
      required: [true, "can't be blank"],
      match: [
        /^[a-zA-Z0-9]+$/,
        "is invalid - alphanumeric characters only (case sensitive)",
      ],
      index: true,
    },
    password: {
      type: String,
      required: [true, "can't be blank"],
    },
  },
  {
    timestamps: true,
  }
);

const userDB = mongoose.connection.useDb("userDB");

module.exports = userDB.model("User", userSchema);
