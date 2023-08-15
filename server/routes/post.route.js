const express = require("express");
const router = express.Router();
const PostController = require("../controllers/post.controller");
const PostValidator = require("../middlewares/post.validator");

router
  // .get("/", PostController.getPosts)
  .post("/", PostValidator.validateCreatePost, PostController.createPost)
  // .get("/:postID", PostController.getPost)
  // .post("/:uid/:postID", PostController.editPost)
  // .delete("/:uid/:postID", PostController.deletePost) // TODO check correct uid 
  // .get("/:uid", PostController.getUserPosts); 

module.exports = router;
