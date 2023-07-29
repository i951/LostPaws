const User = require("../models/user.model");

const UserUtils = {
  existsInDb: async (uid) => {
    let user = await User.findOne({ _id: uid }).exec();
    if (user) return true;
    return false;
  },
  editProfileInDB: async (uid, name, email) => {
    try {
      await User.findOneAndUpdate({ _id: uid }, { name: name, email: email });
      return true;
    } catch (err) {
      console.log("editProfileInDB error: ", err);
      return false;
    }
  },
};

module.exports = UserUtils;
