const express = require("express");
const router = express.Router();
const UserController = require("../controllers/user.controller");
const UserValidator = require("../middlewares/user.validator");

router
  .post("/", UserValidator.validateCreateUser, UserController.createUser)
  .get("/", UserController.getPet);

module.exports = router;
