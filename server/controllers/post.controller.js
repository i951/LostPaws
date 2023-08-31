const Post = require("../models/post.model");
const { getAuth } = require("firebase-admin/auth");
const PostUtils = require("../utils/post.utils");

const PostController = {
  createPost: async (req, res) => {
    const {
      idToken,
      userName,
      postType,
      postTitle,
      photos,
      petType,
      breed,
      colour,
      weight,
      size,
      dateLastSeen,
      locationLastSeen,
      description,
      contactEmail,
      contactPhone,
    } = req.body;

    let checkRevoked = true;
    getAuth()
      .verifyIdToken(idToken, checkRevoked)
      .then(async (decodedToken) => {
        const uid = decodedToken.uid;

        const newPost = Post({
          uid: uid,
          name: userName,
          postType,
          postTitle,
          photos,
          petType,
          breed,
          colour,
          weight,
          size,
          dateLastSeen,
          locationLastSeen,
          description,
          contactEmail,
          contactPhone,
          petIsFound: false,
        });

        try {
          await newPost.save();
          console.log("createPost success");
          return res.status(200).json({ success: true });
        } catch (err) {
          console.log("createPost error: " + err);
          if (err.name === "ValidationError") {
            return res.status(400).json({ error: err.message });
          } else {
            return res.status(400).json({ error: err });
          }
        }
      })
      .catch((error) => {
        console.log("error: ", error.errorInfo.message);
        return res.status(400).json({ error: error.errorInfo.message });
      });
  },
  editPost: async (req, res) => {
    const { postId } = req.params;
    const {
      idToken,
      userName,
      postType,
      postTitle,
      photos,
      petType,
      breed,
      colour,
      weight,
      size,
      dateLastSeen,
      locationLastSeen,
      description,
      contactEmail,
      contactPhone,
    } = req.body;

    let checkRevoked = true;
    getAuth()
      .verifyIdToken(idToken, checkRevoked)
      .then(async (decodedToken) => {
        const uid = decodedToken.uid;

        try {
          await Post.findOneAndUpdate(
            { _id: postId },
            {
              uid: uid,
              name: userName,
              postType,
              postTitle,
              photos,
              petType,
              breed,
              colour,
              weight,
              size,
              dateLastSeen,
              locationLastSeen,
              description,
              contactEmail,
              contactPhone,
              petIsFound: false,
            }
          );
          console.log("editPost success");
          return res.status(200).json({ success: true });
        } catch (err) {
          console.log("editPost error: " + err);
          if (err.name === "ValidationError") {
            return res.status(400).json({ error: err.message });
          } else {
            return res.status(400).json({ error: err });
          }
        }
      })
      .catch((error) => {
        console.log("error: ", error.errorInfo.message);
        return res.status(400).json({ error: error.errorInfo.message });
      });
  },
  getPost: async (req, res) => {
    const { postId } = req.params;

    try {
      let post = await Post.findOne({ _id: postId });
      console.log("post: ", post);
      console.log("getPost success");
      if (post) return res.status(200).json({ success: true, post: post });
      else return res.status(404).json({ error: "Post not found" });
    } catch (err) {
      console.log("getPost error: " + err);
      if (err.name === "ValidationError") {
        return res.status(400).json({ error: err.message });
      } else {
        return res.status(400).json({ error: err });
      }
    }
  },
  getNearbyPosts: async (req, res) => {
    const { latitude, longitude } = req.body;

    PostUtils.distance(latitude, longitude);
    try {
      let allPosts = await Post.find({}).select({
        _id: 1,
        postTitle: 1,
        photos: 1,
        dateLastSeen: 1,
        locationLastSeen: 1,
      });
      console.log("allPosts: ", allPosts);
      let lat2, lon2;
      let nearbyPosts = [];
      allPosts.forEach((post) => {
        lat2 = post.locationLastSeen.latitude;
        lon2 = post.locationLastSeen.longitude;
        let dist = PostUtils.distance(latitude, longitude, lat2, lon2);
        console.log("dist: ", dist)
        if (dist <= 5) {
          console.log("Nearby post detected (within 5km)")
          nearbyPosts.push(post);
        }
      });
      console.log("getNearbyPosts success");
      console.log("nearbyPosts: ", nearbyPosts)
      return res.status(200).json({ success: true, nearbyPosts: nearbyPosts });
    } catch (err) {
      console.log("getNearbyPosts error: " + err);
      if (err.name === "ValidationError") {
        return res.status(400).json({ error: err.message });
      } else {
        return res.status(400).json({ error: err });
      }
    }
  },
  // getPosts: (req, res) => {
  //   const postType = req.query.postType;
  //   const petIsFound = req.query.petIsFound;
  //   const petName = req.query.petName;
  //   const petType = req.query.petType;
  //   const petColour = req.query.petColour;
  //   const petSize = req.query.petSize;
  //   const locationLastSeen = req.query.locationLastSeen;
  //   const dateLastSeen = req.query.dateLastSeen;
  //   const sortBy = req.query.sortBy;

  //   console.log("postType: ", postType);

  //   // TODO add filters
  //   if (petIsFound) {
  //     Post.find({ petIsFound: petIsFound })
  //       .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
  //       .sort({ createdAt: 1 })
  //       .exec((err, posts) => {
  //         return res.status(200).json(posts);
  //       });
  //     return;
  //   }

  //   Post.find()
  //     .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
  //     .sort({ createdAt: 1 })
  //     .exec((err, posts) => {
  //       return res.status(200).json(posts);
  //     });

  //   // return res.status(200).json(postType)
  // },
  // deletePost: (req, res) => {
  //   const { uid, postID } = req.params;

  //   Post.deleteOne({ _id: postID, uid: uid }).exec((err, result) => {
  //     if (err) return res.status(400).json({ success: false, error: err });
  //     return res.status(200).json({ success: true });
  //   });
  // },
  // getUserPosts: (req, res) => {
  //   const { uid } = req.params;

  //   Post.find({ uid: uid })
  //     .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
  //     .sort({ createdAt: 1 })
  //     .exec((err, posts) => {
  //       console.log("getUserPosts posts: ", posts);
  //       return res.status(200).json(posts);
  //     });
  // },
};

module.exports = PostController;
