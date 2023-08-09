const express = require("express");
const PostController = require("../controllers/post.controller");
const router = express.Router();

router
  .get("/", PostController.getPosts)
  .post("/", PostController.uploadPost)
  .get("/:postID", PostController.getPost)
  .post("/:uid/:postID", PostController.editPost)
  .delete("/:uid/:postID", PostController.deletePost) // TODO check correct uid 
  .get("/:uid", PostController.getUserPosts); 

module.exports = router;
