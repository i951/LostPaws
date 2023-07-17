const express = require("express");
const { body, query } = require("express-validator");
const userController = require("../controllers/user.controller");
const router = express.Router();

router
  .post(
    "/",
    [body("userID").exists(), body("name").isAlpha(), body("email").isEmail()],
    userController.createUser
  )
  .get("/", userController.getPet);

module.exports = router;
