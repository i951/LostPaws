const app = require('../../index')
const supertest = require('supertest')

describe('createUser', () => {
    test('invalid name', async () => {
        const payload = {
            userID: 'a',
            name: '%%$#(@!',
            email: 'a@b.c'
        }

        const res = await supertest(app)
            .post('/users/')
            .send(payload)
        expect(res.status).toEqual(400)
        expect(res.type).toEqual(expect.stringContaining('json'))
        expect(res.body).toHaveProperty('error')
    })
})