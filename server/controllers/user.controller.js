const User = require("../models/user.model");
const { getAuth } = require("firebase-admin/auth");
const UserUtils = require("../utils/user.utils");

const UserController = {
  createUser: async (req, res) => {
    const { uid, name, email } = req.body;

    let newUser = User({
      _id: uid,
      name,
      email,
    });

    try {
      await newUser.save();
      console.log("createUser success");
      return res.status(200).json({ success: true });
    } catch (err) {
      console.log("createUser error: " + err);
      if (err.name === "ValidationError") {
        return res.status(400).json({ error: err.message });
      }
    }
  },
  login: (req, res) => {
    const { idToken } = req.body;
    // idToken comes from the client app
    // Verify the ID token while checking if the token is revoked by passing
    // checkRevoked true.
    let checkRevoked = true;
    getAuth()
      .verifyIdToken(idToken, checkRevoked)
      .then((decodedToken) => {
        const uid = decodedToken.uid;
        getAuth()
          .getUser(uid)
          .then((userRecord) => {
            // See the UserRecord reference doc for the contents of userRecord.
            console.log(
              `Successfully fetched user data: ${userRecord.toJSON()}`
            );
            return res
              .status(200)
              .json({ success: true, userRecord: userRecord });
          })
          .catch((error) => {
            console.log("Error fetching user data:", error);
            return res.status(400).json({ success: false, error: error });
          });
      })
      .catch((error) => {
        return res.status(400).json({ success: false, error: error });
      });
  },
  getProfile: (req, res) => {
    const { uid } = req.params;

    getAuth()
      .getUser(uid)
      .then((userRecord) => {
        // See the UserRecord reference doc for the contents of userRecord.
        console.log(`Successfully fetched user data: ${userRecord.toJSON()}`);
        return res.status(200).json({ success: true, userRecord: userRecord });
      })
      .catch((error) => {
        console.log("Error fetching user data:", error);
        return res.status(400).json({ success: false, error: error });
      });
  },
  // TODO: integration test with idToken from frontend
  editProfile: (req, res) => {
    let { uid, name, email } = req.body;
    
    getAuth()
      .updateUser(uid, {
        email: email,
        displayName: name,
      })
      .then(async (userRecord) => {
        // See the UserRecord reference doc for the contents of userRecord.
        console.log("Successfully updated user", userRecord.toJSON());

        let editSuccessfully = await UserUtils.editProfileInDB(
          uid,
          name,
          email
        );
        if (editSuccessfully) {
          return res
            .status(200)
            .json({ success: true, userRecord: userRecord });
        } else {
          return res.status(400).json({
            success: false,
            error: "Unable to update user profile in database",
          });
        }
      })
      .catch((error) => {
        console.log("Error updating user:", error);
        return res.status(400).json({ success: false, error: error });
      });
  },
  getPet: (req, res) => {
    return res.status(200).json("(ⓛ ω ⓛ *)");
  },
};

module.exports = UserController;
