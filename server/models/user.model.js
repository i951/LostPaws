const mongoose = require("mongoose");
/* 
  New user is populated when Firebase authentication is used to create new user AFTER email verification.
*/

const userSchema = mongoose.Schema(
  {
    // https://firebase.google.com/docs/auth/users#:~:text=Firebase%20users%20have%20a%20fixed,iOS%2C%20Android%2C%20web).
    _id: {
      type: String,
    },
    name: {
      type: String,
      unique: true,
      required: [true, "can't be blank"],
      match: [
        /^[a-zA-Z0-9]+$/,
        "is invalid - alphanumeric characters only (case sensitive)",
      ],
      index: true,
    },
    email: {
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
