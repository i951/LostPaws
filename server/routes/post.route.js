const express = require("express");
const PostController = require("../controllers/post.controller");
const router = express.Router();

router
  .get("/", PostController.getPosts)
  .post("/", PostController.uploadPost)
  .get("/:postID", PostController.getPost)
  .post("/:userID/:postID", PostController.editPost)
  .delete("/:userID/:postID", PostController.deletePost) // TODO check correct userID 
  .get("/:userID", PostController.getUserPosts);


module.exports = router;
