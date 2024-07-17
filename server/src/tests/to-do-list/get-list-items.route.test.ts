import { uuid } from "common"
import { ToDoList } from "../../config"
import { getTestItem, Mongo, startMongo, TestRequest } from "../test-utils"
import { route } from "../../functions/to-do-list/get-list-items.route"
import { InvocationContext } from "@azure/functions"

let mongo: Mongo

beforeAll(async () => {
    mongo = await startMongo()
})

afterAll(async () => {
    mongo.stopMongo()
})


it('should return the items', async () => {
    const item1 = await ToDoList.add(getTestItem())
    const item2 = await ToDoList.add({ ...getTestItem(), id: uuid() })

    const context = new InvocationContext()
    const request = new TestRequest({
        method: 'GET',
    })

    const response = await route.handler(request, context)

    expect(response).toEqual({
        jsonBody: [
            {
                ...item1,
                createdAt: expect.any(Date),
                updatedAt: expect.any(Date)
            },
            {
                ...item2,
                createdAt: expect.any(Date),
                updatedAt: expect.any(Date)
            }
        ]
    })
})