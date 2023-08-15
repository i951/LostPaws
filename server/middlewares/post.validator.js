const UserUtils = require("../utils/user.utils");
const { check, validationResult } = require("express-validator");

const PostValidator = {
  validateCreatePost: [
    check("uid")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Uid cannot be empty!")
      .bail()
      .isLength({ min: 3 })
      .withMessage("Minimum 3 characters required!")
      .bail()
      .custom(async (uid) => {
        const existsInDb = await UserUtils.existsInDb(uid);
        if (existsInDb) {
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
  // validateLogin: [
  //   check("idToken")
  //     .not()
  //     .isEmpty()
  //     .withMessage("idToken cannot be empty!")
  //     .bail(),
  //   (req, res, next) => {
  //     const errors = validationResult(req);
  //     if (!errors.isEmpty())
  //       return res.status(422).json({ errors: errors.array() });
  //     next();
  //   },
  // ],
  // validateGetProfle: [
  //   check("uid")
  //     .trim()
  //     .escape()
  //     .isAlpha()
  //     .withMessage("uid must be alphabetic!")
  //     .bail()
  //     .isLength({ min: 5 })
  //     .withMessage("Minimum 5 characters required!")
  //     .bail()
  //     .custom(async (uid) => {
  //       const existsInDb = await UserUtils.existsInDb(uid);
  //       if (!existsInDb) {
  //         // Will use the below as the error message
  //         throw new Error(); //("A user already exists with this user ID");
  //       }
  //     })
  //     .withMessage("This user does not exist!")
  //     .bail(),
  //   (req, res, next) => {
  //     const errors = validationResult(req);
  //     if (!errors.isEmpty())
  //       return res.status(422).json({ errors: errors.array() });
  //     next();
  //   },
  // ],
  // validateEditProfile: [
  //   check("uid")
  //     .trim()
  //     .escape()
  //     .not()
  //     .isEmpty()
  //     .withMessage("uid cannot be empty!")
  //     .bail()
  //     .isLength({ min: 3 })
  //     .withMessage("Minimum 3 characters required!")
  //     .bail()
  //     .custom(async (uid) => {
  //       const existsInDb = await UserUtils.existsInDb(uid);
  //       if (!existsInDb) {
  //         throw new Error(); //("A user already exists with this user ID");
  //       }
  //     })
  //     .withMessage("A user with this uid does not exist in the database!")
  //     .bail(),
  //   check("name")
  //     .trim()
  //     .escape()
  //     .not()
  //     .isEmpty()
  //     .withMessage("Name cannot be empty!")
  //     .bail()
  //     .isLength({ min: 3 })
  //     .withMessage("Minimum 3 characters required!")
  //     .bail()
  //     .isAlpha()
  //     .withMessage("Name must be alphabetic!")
  //     .bail(),
  //   check("email")
  //     .trim()
  //     .normalizeEmail()
  //     .not()
  //     .isEmpty()
  //     .withMessage("Invalid email address!")
  //     .bail()
  //     .exists()
  //     .withMessage("Must have an email address!")
  //     .bail()
  //     .isEmail()
  //     .withMessage("Invalid email address format!")
  //     .bail(),
  //   (req, res, next) => {
  //     const errors = validationResult(req);
  //     if (!errors.isEmpty())
  //       return res.status(422).json({ errors: errors.array() });
  //     next();
  //   },
  // ],
};

module.exports = PostValidator;
