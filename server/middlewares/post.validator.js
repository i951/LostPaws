const { check, validationResult } = require("express-validator");

const PostValidator = {
  validatePost: [
    check("idToken")
      // TODO: check if should put idToken in header instead of body
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("IdToken cannot be empty")
      .bail()
      .isLength({ min: 3 })
      .withMessage("Minimum 3 characters required")
      .bail(),
    check("userName")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Name cannot be empty")
      .bail()
      .isAlphanumeric("en-US", { ignore: " " })
      .withMessage("Name must be alphanumeric")
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
      .isIn(["Mini", "Small", "Medium", "Large"])
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
      .withMessage("Must be a string")
      .bail(),
    check("locationLastSeen.city")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("City cannot be empty")
      .bail()
      .isString()
      .withMessage("Must be a string")
      .bail(),
    check("locationLastSeen.regionalDistrict")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Regional district cannot be empty")
      .bail()
      .isString()
      .withMessage("Must be a string")
      .bail(),
    check("locationLastSeen.province")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Province cannot be empty")
      .bail()
      .isString()
      .withMessage("Must be a string")
      .bail(),
    check("locationLastSeen.country")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("Country cannot be empty")
      .bail()
      .isString()
      .withMessage("Must be a string")
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
      console.log("errors.array(): ", errors.array());
      if (!errors.isEmpty())
        return res.status(422).json({ errors: errors.array() });
      next();
    },
  ],
  validateGetPost: [
    check("postId")
      .trim()
      .escape()
      .not()
      .isEmpty()
      .withMessage("postId cannot be empty")
      .bail()
      .isAlphanumeric()
      .withMessage("postId must be alphanumeric")
      .bail(),
    (req, res, next) => {
      const errors = validationResult(req);
      console.log("here errors.array(): ", errors.array());
      if (!errors.isEmpty())
        return res.status(422).json({ errors: errors.array() });
      next();
    },
  ],
};

module.exports = PostValidator;
