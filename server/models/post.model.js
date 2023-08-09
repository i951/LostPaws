const { v4: uuidv4 } = require("uuid");
const mongoose = require("mongoose");

const postSchema = mongoose.Schema(
  {
    _id: {
      type: String,
      default: () => uuidv4().replaceAll("-", ""),
    },
    uid: {
      type: String,
      required: [true, "is required"],
      index: true,
    },
    postType: {
      type: String,
      enum: ["sighting", "lost", "found"],
      default: "sighting",
    },
    postTitle: {
      type: String,
      default: "Post title",
    },
    petIsFound: {
      type: Boolean,
      default: false,
    },
    petName: {
      type: String,
      default: "No name provided",
    },
    petType: {
      type: String,
      enum: [
        "dog",
        "cat",
        "bird",
        "rabbit",
        "rodent",
        "frog",
        "turtle",
        "other",
      ],
      default: "other",
    },
    petColour: {
      type: String,
      default: "No colour provided",
    },
    petSize: {
      type: String,
      default: "No size provided",
    },
    dateLastSeen: {
      type: String,
      default: "No date provided",
    },
    locationLastSeen: {
      type: String,
      default: "No location provided",
    },
    contactInfo: {
      type: String,
      default: "No contact provided",
    },
    additionalInfo: {
      type: String,
      default: "",
    },
    petImage: {
      type: String,
      default: "",
    },
  },
  {
    timestamps: true,
  }
);

postSchema.path("postType").validate((postType) => {
  let postTypes = ["posting", "sighting"];
  return postTypes.includes(postType.toLowerCase());
}, "Invalid postType");

postSchema.path("petType").validate((petType) => {
  let petTypes = [
    "dog",
    "bird",
    "bunny",
    "reptile",
    "amphibian",
    "cat",
    "rodent",
    "other",
  ];
  return petTypes.includes(petType.toLowerCase());
}, "Invalid petType");

const postDB = mongoose.connection.useDb("postDB");
module.exports = postDB.model("Post", postSchema);
