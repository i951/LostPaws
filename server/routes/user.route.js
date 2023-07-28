const express = require("express");
const router = express.Router();
const UserController = require("../controllers/user.controller");
const UserValidator = require("../middlewares/user.validator");

router
  .post("/", UserValidator.validateCreateUser, UserController.createUser)
  .post("/login", UserValidator.validateLogin, UserController.login)
  .get("/:uid", UserController.getUserProfile)
  .post("/edit", UserValidator.validateEditProfile, UserController.editProfile)
  .get("/", UserController.getPet);

module.exports = router;
