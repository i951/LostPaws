const express = require("express");
const postController = require("../controllers/post.controller");
const router = express.Router();

router
  .get("/", postController.getPosts)
  .post("/", postController.uploadPost)
  .get("/:postID", postController.getPost)
  .get("/:userID", postController.getUserPosts)
  .post("/:userID/:postID", postController.editPost);

module.exports = router;
