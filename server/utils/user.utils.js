const User = require("../models/user.model");

const UserUtils = {
  isDuplicateUserID: async (userID) => {
    let user = await User.findOne({ _id: userID }).exec();
    if (user) return true;
    return false;
  },
};

module.exports = UserUtils;
