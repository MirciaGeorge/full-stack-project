import { InvocationContext } from "@azure/functions"
import { getTestItem, Mongo, startMongo, TestRequest } from "../test-utils"
import { ToDoList } from "../../config"
import { ToDoListItem } from "common"
import { route } from "../../functions/to-do-list/patch-list-item.route"

let mongo: Mongo

beforeAll(async () => {
    mongo = await startMongo()
})

afterAll(async () => {
    mongo.stopMongo()
})

it('should update the item', async () => {
    const item: ToDoListItem = await ToDoList.add(getTestItem())
    const payload = { name: 'New test name' }

    const context = new InvocationContext()
    const request = new TestRequest({
        method: 'PATCH',
        params: { id: item.id },
        body: { string: JSON.stringify(payload) }
    })

    const response = await route.handler(request, context)

    expect(response).toEqual({
        jsonBody: {
            ...item,
            ...payload,
            createdAt: expect.any(Date),
            updatedAt: expect.any(Date)
        }
    })
})