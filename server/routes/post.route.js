const express = require("express");
const postController = require("../controllers/post.controller");
const router = express.Router();

router
  .get("/", postController.getPosts)
  .post("/", postController.uploadPost)
  .get("/:postID", postController.getPost)
  .post("/:userID/:postID", postController.editPost)
  .delete("/:userID/:postID", postController.deletePost) // TODO check correct userID 
  .get("/:userID", postController.getUserPosts);


module.exports = router;
