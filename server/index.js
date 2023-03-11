require('dotenv').config()
const http = require('http')
const express = require('express')
const mongoose = require('mongoose')

// Routes
const userRouter = require('./routes/user.route.js')

// MongoDB
const uri = `mongodb+srv://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@cluster0.qafmunu.mongodb.net/?retryWrites=true&w=majority`
mongoose.set('strictQuery', false)
try {
    mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true }, () => {
        console.log('MongoDB connected')
    })
} catch (error) {
    console.log('Could not connect to MongoDB')
}

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use('/users', userRouter)

const port = 5205
const server = http.createServer(app)

// Start server
server.listen(port)
server.on('listening', () => {
    console.log('Listening on port', port)
})

app.get('/', (req, res) => {
    res.send('ʕ ·(エ)· ʔ')
})
