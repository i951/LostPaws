const User = require('../models/user.model')

const userController = {
    getPet: (req, res) => {
        return res.status(200).json('(ⓛ ω ⓛ *)')
    },
}

module.exports = userController