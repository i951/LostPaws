const User = require("../models/user.model");

const userController = {
  createUser: (req, res) => {
    const {
      userID,
      name, 
      email
    } = req.body;

    let newUser = User({
      __id: userID,
      name, 
      email
    });

    newUser.save((err) => {
      if (err) {
        console.log("createUser error: " + err);
        if (err.name === "ValidationError") {
          return res.status(400).json({ error: err.message });
        }
      }
      console.log("createUser success");
      return res.status(200).json({ success: true });
    });
  },
  getPet: (req, res) => {
    return res.status(200).json("(ⓛ ω ⓛ *)");
  },
};

module.exports = userController;
