const UserUtils = require("../utils/user.utils");
const { check, validationResult } = require("express-validator");

const UserValidator = {
  validateCreateUser: [
    check("userID")
      .not()
      .isEmpty()
      .withMessage("User ID cannot be empty!")
      .bail()
      .isLength({ min: 3 })
      .withMessage("Minimum 3 characters required!")
      .bail()
      .custom(async (userID) => {
        const isDuplicate = await UserUtils.isDuplicateUserID(userID);
        if (isDuplicate) {
          // Will use the below as the error message
          throw new Error(); //("A user already exists with this user ID");
        }
      })
      .withMessage("A user already exists with this user ID!")
      .bail(),
    check("name")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Name cannot be empty!")
      .bail()
      .isLength({ min: 3 })
      .withMessage("Minimum 3 characters required!")
      .bail()
      .isAlpha()
      .withMessage("Name must be alphabetic!")
      .bail(),
    check("email")
      .trim()
      .normalizeEmail()
      .not()
      .isEmpty()
      .withMessage("Invalid email address!")
      .bail()
      .exists()
      .withMessage("Must have an email address!")
      .bail()
      .isEmail()
      .withMessage("Invalid email address format!")
      .bail(),
    (req, res, next) => {
      const errors = validationResult(req);
      if (!errors.isEmpty())
        return res.status(422).json({ errors: errors.array() });
      next();
    },
  ],
};

module.exports = UserValidator;
