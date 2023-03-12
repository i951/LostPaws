const Post = require('../models/post.model')

const postController = {
    getPosts: (req, res) => {
        const postType = req.query.postType
        const petIsFound = req.query.petIsFound
        const petName = req.query.petName
        const petType = req.query.petType
        const petColour = req.query.petColour
        const petSize = req.query.petSize
        const locationLastSeen = req.query.locationLastSeen
        const dateLastSeen = req.query.dateLastSeen
        const sortBy = req.query.sortBy

        console.log('postType: ', postType)

        // TODO add filters
        if (petIsFound) {
            Post
                .find({ petIsFound: petIsFound })
                .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
                .sort({ createdAt: 1 })
                .exec((err, posts) => {
                    return res.status(200).json(posts)
                })
            return
        }

        Post
            .find()
            .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
            .sort({ createdAt: 1 })
            .exec((err, posts) => {
                return res.status(200).json(posts)
            })


        // return res.status(200).json(postType)
    },
    uploadPost: (req, res) => {
        const {
            userID,
            postType,
            postTitle,
            petType,
            petColour,
            petSize,
            dateLastSeen,
            locationLastSeen,
            contactInfo,
            additionalInfo
        } = req.body 

        let newPost = Post({
            userID,
            postType,
            postTitle,
            petType,
            petColour,
            petSize,
            dateLastSeen,
            locationLastSeen,
            contactInfo,
            additionalInfo
        })

        newPost.save((err) => {
            if (err) {
                console.log('uploadPost error: ' + err)
                if (err.name === 'ValidationError') {
                    return res.status(400).json({ error: err.message })
                }
            }
            console.log('uploadPost success')
            return res.status(200).json({ success: true })
        })

    },
    editPost: (req, res) => {
        const { userID, postID } = req.params
        const {
            postType,
            postTitle,
            petType,
            petColour,
            petSize,
            dateLastSeen,
            locationLastSeen,
            contactInfo,
            additionalInfo
        } = req.body

        Post.findOneAndUpdate(
            { userID: userID, _id: postID },
            {
                postType: postType, postTitle: postTitle, petType: petType, petColour: petColour, petSize: petSize,
                dateLastSeen: dateLastSeen, locationLastSeen: locationLastSeen, contactInfo: contactInfo, additionalInfo: additionalInfo
            },
            { new: true },
            (err, result) => {
                if (err) {
                    console.log('editPost error: ', err)
                    return res.status(400).json({ error: err })
                }
                console.log('editPost success')
                return res.status(200).json({ success: true })
            })
    }, 
    getUserPosts: (req, res) => {
        const { userID } = req.params

        Post
            .find( { userID: userID })
            .select({ postTitle: 1, locationLastSeen: 1, dateLastSeen: 1 })
            .sort({ createdAt: 1 })
            .exec((err, posts) => {
                console.log('getUserPosts posts: ', posts)
                return res.status(200).json(posts)
            })
    }
}

module.exports = postController