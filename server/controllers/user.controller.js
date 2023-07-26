const User = require("../models/user.model");
const { getAuth } = require("firebase-admin/auth");

const UserController = {
  createUser: (req, res) => {
    const { userID, name, email } = req.body;

    let newUser = User({
      _id: userID,
      name,
      email,
    });

    newUser.save((err) => {
      if (err) {
        console.log("createUser error: " + err);
        if (err.name === "ValidationError") {
          return res.status(400).json({ error: err.message });
        }
      }
      console.log("createUser success");
      return res.status(200).json({ success: true });
    });
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
        // if (error.code == "auth/id-token-revoked") {
        //   // Token has been revoked. Inform the user to reauthenticate or signOut() the user.
        //   return res.status(400).json({ success: false, error: error });
        // } else {
        //   // Token is invalid.
        //   return res.status(400).json({ success: false, error: error });
        // }
      });
  },
  getUserProfile: (req, res) => {
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
  getPet: (req, res) => {
    return res.status(200).json("(ⓛ ω ⓛ *)");
  },
};

module.exports = UserController;
