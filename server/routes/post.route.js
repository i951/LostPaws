const express = require("express");
const router = express.Router();
const PostController = require("../controllers/post.controller");
const PostValidator = require("../middlewares/post.validator");

router
  .post("/", PostValidator.validatePost, PostController.createPost)
  .post("/:postId", PostValidator.validatePost, PostController.editPost)
  .get("/:postID", PostController.getPost);
// .get("/", PostController.getPosts)
// .get("/:postID", PostController.getPost)
// .post("/:uid/:postID", PostController.editPost)
// .delete("/:uid/:postID", PostController.deletePost) // TODO check correct uid
// .get("/:uid", PostController.getUserPosts);

module.exports = router;
