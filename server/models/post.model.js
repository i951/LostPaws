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
    name: {
      type: String,
      required: [true, "is required"],
    },
    postType: {
      type: String,
      enum: ["LOST", "SIGHTING"],
      default: "No post type provided",
      required: [true, "is required"],
    },
    postTitle: {
      type: String,
      default: "Post title",
      required: [true, "is required"],
    },
    photos: {
      type: Array,
      required: [true, "is required"],
    },
    petType: {
      type: String,
      enum: [
        "DOG",
        "CAT",
        "BIRD",
        "BUNNY",
        "REPTILE",
        "AMPHIBIAN",
        "RODENT",
        "OTHER",
      ],
      default: "No pet type provided",
      required: [true, "is required"],
    },
    breed: {
      type: String,
      default: "No breed provided",
      required: [true, "is required"],
    },
    colour: {
      type: mongoose.SchemaTypes.Mixed,
      required: [true, "is required"],
    },
    weight: {
      type: String,
      default: "No weight provided",
      required: [true, "is required"],
    },
    size: {
      type: String,
      enum: [
        "Mini",
        "Small",
        "Medium",
        "Large",
      ],
      default: "No size provided",
      required: [true, "is required"],
    },
    dateLastSeen: {
      type: String,
      default: "No date provided",
      required: [true, "is required"],
    },
    locationLastSeen: {
      type: mongoose.SchemaTypes.Mixed,
      required: [true, "is required"],
    },
    description: {
      type: String,
      default: "No description provided",
      required: [true, "is required"],
    },
    contactEmail: {
      type: String,
      default: "No email provided",
      required: [true, "is required"],
    },
    contactPhone: {
      type: String,
      default: "No phone provided",
      required: [true, "is required"],
    },
    petIsFound: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

postSchema.path("postType").validate((postType) => {
  let postTypes = ["lost", "sighting"];
  return postTypes.includes(postType.toLowerCase());
}, "Invalid postType");

postSchema.path("petType").validate((petType) => {
  let petTypes = [
    "dog",
    "cat",
    "bird",
    "bunny",
    "reptile",
    "amphibian",
    "rodent",
    "other",
  ];
  return petTypes.includes(petType.toLowerCase());
}, "Invalid petType");

const postDB = mongoose.connection.useDb("postDB");
module.exports = postDB.model("Post", postSchema);
