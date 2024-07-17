import { User } from "../../config"
import { route } from "../../functions/user/get-user-data.route"
import { getUserData, Mongo, startMongo, TestRequest } from "../test-utils"
import { InvocationContext } from "@azure/functions"

let mongo: Mongo

beforeAll(async () => {
    mongo = await startMongo()
})

afterAll(async () => {
    mongo.stopMongo()
})

it('should return user data', async () => {
    const user = await User.add(getUserData())

    const context = new InvocationContext()
    const request = new TestRequest({
        method: 'GET',
        params: { id: user.id }
    })

    const response = await route.handler(request, context)

    expect(response).toEqual({
        jsonBody: {
            ...user,
            createdAt: expect.any(Date),
            updatedAt: expect.any(Date)
        }
    })
})