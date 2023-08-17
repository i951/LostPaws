const UserUtils = require("../utils/user.utils");
const { check, validationResult } = require("express-validator");

const PostValidator = {
  validateCreatePost: [
    check("uid")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Uid cannot be empty")
      .bail()
      .isLength({ min: 3 })
      .withMessage("Minimum 3 characters required")
      .bail()
      .custom(async (uid) => {
        const existsInDb = await UserUtils.existsInDb(uid);
        if (existsInDb) {
          // Will use the below as the error message
          throw new Error(); //("A user already exists with this user ID");
        }
      })
      .withMessage("A user already exists with this user ID")
      .bail(),
    check("userName")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Name cannot be empty")
      .bail()
      .isAlpha()
      .withMessage("Name must be alphabetic")
      .bail(),
    check("postType")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Post type cannot be empty")
      .bail()
      .isIn(["LOST", "SIGHTING"])
      .withMessage("Post type must be either 'LOST' or 'SIGHTING'")
      .bail(),
    check("postTitle")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Post title cannot be empty")
      .bail(),
    check("photos").optional().trim().escape(),
    check("petType")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Pet type cannot be empty")
      .bail()
      .isIn([
        "DOG",
        "CAT",
        "BIRD",
        "BUNNY",
        "REPTILE",
        "AMPHIBIAN",
        "RODENT",
        "OTHER",
      ])
      .withMessage("Invalid pet type")
      .bail(),
    check("breed")
      .trim()
      .not()
      .isEmpty()
      .withMessage("Breed cannot be empty")
      .bail()
      .isString()
      .withMessage("Breed must be a string")
      .bail(),
    check("colour")
      .not()
      .isEmpty()
      .withMessage("Colour cannot be empty")
      .bail(),
    check("colour.hexValue")
      .not()
      .isEmpty()
      .withMessage("HexValue cannot be empty")
      .bail()
      .isInt()
      .withMessage("HexValue must be an integer")
      .bail(),
    check("colour.colourName")
      .not()
      .isEmpty()
      .withMessage("ColourName cannot be empty")
      .bail()
      .isIn([
        "Chocolate Brown",
        "Tan Brown",
        "Cream",
        "Gold",
        "Orange",
        "Yellow Orange",
        "Yellow",
        "Lime Green",
        "Light Green",
        "Green",
        "White",
        "Black",
        "Grey",
        "Light Blue",
        "Dark Blue",
        "Red",
      ])
      .withMessage("Invalid colourName")
      .bail(),
    check("weight")
      .not()
      .isEmpty()
      .withMessage("Weight cannot be empty")
      .bail()
      .isString()
      .withMessage("Weight must be a string")
      .bail(),
    check("size")
      .not()
      .isEmpty()
      .withMessage("Size cannot be empty")
      .bail()
      .isString()
      .withMessage("Size must be a string")
      .bail()
      .isIn([
        "Mini",
        "Small",
        "Medium",
        "Large",
      ])
      .withMessage("Invalid size")
      .bail(),
    check("locationLastSeen")
      .not()
      .isEmpty()
      .withMessage("Location cannot be empty")
      .bail(),
    check("locationLastSeen.latitude")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Latitude cannot be empty")
      .bail()
      .isDecimal()
      .withMessage("Latitude must be a number")
      .bail(),
    check("locationLastSeen.longitude")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Longitude cannot be empty")
      .bail()
      .isDecimal()
      .withMessage("Longitude must be a number")
      .bail(),
    check("locationLastSeen.street")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Street cannot be empty")
      .bail()
      .isString()
      .withMessage("Invalid characters")
      .bail(),
    check("locationLastSeen.city")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("City cannot be empty")
      .bail()
      .isString()
      .withMessage("Invalid characters")
      .bail(),
    check("locationLastSeen.province")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Province cannot be empty")
      .bail()
      .isString()
      .withMessage("Invalid characters")
      .bail(),
    check("locationLastSeen.country")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Country cannot be empty")
      .bail()
      .isString()
      .withMessage("Invalid characters")
      .bail(),
    check("locationLastSeen.postalCode")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Postal code cannot be empty")
      .bail()
      .isAlphanumeric("en-US", { ignore: " " })
      .withMessage("Invalid characters")
      .bail()
      .isLength({ min: 7, max: 7 })
      .withMessage("Invalid length (Format: ABC XYZ)")
      .bail(),
    check("description").trim().escape(),
    check("contactEmail")
      .trim()
      .escape()
      .normalizeEmail()
      .not()
      .isEmpty()
      .withMessage("Invalid email address")
      .bail()
      .exists()
      .withMessage("Must have an email address")
      .bail()
      .isEmail()
      .withMessage("Invalid email address format")
      .bail(),
    check("contactPhone")
      .trim()
      .escape()
      .optional()
      .isLength({ min: 10, max: 10 })
      .withMessage("Invalid phone number length")
      .bail()
      .matches(/^\d+$/)
      .withMessage("Invalid characters")
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
  //     .withMessage("idToken cannot be empty")
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
  //     .withMessage("uid must be alphabetic")
  //     .bail()
  //     .isLength({ min: 5 })
  //     .withMessage("Minimum 5 characters required")
  //     .bail()
  //     .custom(async (uid) => {
  //       const existsInDb = await UserUtils.existsInDb(uid);
  //       if (!existsInDb) {
  //         // Will use the below as the error message
  //         throw new Error(); //("A user already exists with this user ID");
  //       }
  //     })
  //     .withMessage("This user does not exist")
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
  //     .withMessage("uid cannot be empty")
  //     .bail()
  //     .isLength({ min: 3 })
  //     .withMessage("Minimum 3 characters required")
  //     .bail()
  //     .custom(async (uid) => {
  //       const existsInDb = await UserUtils.existsInDb(uid);
  //       if (!existsInDb) {
  //         throw new Error(); //("A user already exists with this user ID");
  //       }
  //     })
  //     .withMessage("A user with this uid does not exist in the database")
  //     .bail(),
  //   check("name")
  //     .trim()
  //     .escape()
  //     .not()
  //     .isEmpty()
  //     .withMessage("Name cannot be empty")
  //     .bail()
  //     .isLength({ min: 3 })
  //     .withMessage("Minimum 3 characters required")
  //     .bail()
  //     .isAlpha()
  //     .withMessage("Name must be alphabetic")
  //     .bail(),
  //   check("email")
  //     .trim()
  //     .normalizeEmail()
  //     .not()
  //     .isEmpty()
  //     .withMessage("Invalid email address")
  //     .bail()
  //     .exists()
  //     .withMessage("Must have an email address")
  //     .bail()
  //     .isEmail()
  //     .withMessage("Invalid email address format")
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
