const Post = require("../models/post.model");
const { getAuth } = require("firebase-admin/auth");

const PostController = {
  createPost: (req, res) => {
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

    // TODO: replace uid with idToken to verify user identity
    let checkRevoked = true;
    getAuth()
      .verifyIdToken(idToken, checkRevoked)
      .then((decodedToken) => {
        const uid = decodedToken.uid;

        let newPost = Post({
          uid,
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

        newPost.save((err) => {
          if (err) {
            console.log("createPost error: " + err);
            if (err.name === "ValidationError") {
              return res.status(400).json({ error: err.message });
            }
          }
          console.log("createPost success");
          return res.status(200).json({ success: true });
        });
      })
      .catch((error) => {
        console.log("error: ", error.errorInfo.message)
        return res.status(400).json({ error: error.errorInfo.message });
        // if (error.code == "auth/id-token-revoked") {
        //   // Token has been revoked. Inform the user to reauthenticate or signOut() the user.
        //   return res.status(400).json({ success: false, error: error });
        // } else {
        //   // Token is invalid.
        //   return res.status(400).json({ success: false, error: error });
        // }
      });
  },
  getPosts: (req, res) => {
    const postType = req.query.postType;
    const petIsFound = req.query.petIsFound;
    const petName = req.query.petName;
    const petType = req.query.petType;
    const petColour = req.query.petColour;
    const petSize = req.query.petSize;
    const locationLastSeen = req.query.locationLastSeen;
    const dateLastSeen = req.query.dateLastSeen;
    const sortBy = req.query.sortBy;

    console.log("postType: ", postType);

    // TODO add filters
    if (petIsFound) {
      Post.find({ petIsFound: petIsFound })
        .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
        .sort({ createdAt: 1 })
        .exec((err, posts) => {
          return res.status(200).json(posts);
        });
      return;
    }

    Post.find()
      .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
      .sort({ createdAt: 1 })
      .exec((err, posts) => {
        return res.status(200).json(posts);
      });

    // return res.status(200).json(postType)
  },
  getPost: (req, res) => {
    const { postID } = req.params;

    Post.findOne({ _id: postID }).exec((err, post) => {
      if (err) return res.status(400).json({ err: err });
      return res.status(200).json(post);
    });
  },
  editPost: (req, res) => {
    const { uid, postID } = req.params;
    const {
      postType,
      postTitle,
      petType,
      petColour,
      petSize,
      dateLastSeen,
      locationLastSeen,
      contactInfo,
      additionalInfo,
    } = req.body;

    Post.findOneAndUpdate(
      { uid: uid, _id: postID },
      {
        postType: postType,
        postTitle: postTitle,
        petType: petType,
        petColour: petColour,
        petSize: petSize,
        dateLastSeen: dateLastSeen,
        locationLastSeen: locationLastSeen,
        contactInfo: contactInfo,
        additionalInfo: additionalInfo,
      },
      { new: true },
      (err, result) => {
        if (err) {
          console.log("editPost error: ", err);
          return res.status(400).json({ error: err });
        }
        console.log("editPost success");
        return res.status(200).json({ success: true });
      }
    );
  },
  deletePost: (req, res) => {
    const { uid, postID } = req.params;

    Post.deleteOne({ _id: postID, uid: uid }).exec((err, result) => {
      if (err) return res.status(400).json({ success: false, error: err });
      return res.status(200).json({ success: true });
    });
  },
  getUserPosts: (req, res) => {
    const { uid } = req.params;

    Post.find({ uid: uid })
      .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
      .sort({ createdAt: 1 })
      .exec((err, posts) => {
        console.log("getUserPosts posts: ", posts);
        return res.status(200).json(posts);
      });
  },
};

module.exports = PostController;
