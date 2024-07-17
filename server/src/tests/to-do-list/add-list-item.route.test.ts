
import { ToDoListItem } from 'common'
import { getTestItem, Mongo, startMongo, TestRequest } from '../test-utils'
import { InvocationContext } from '@azure/functions'
import { route } from '../../functions/to-do-list/add-list-item.route'

let mongo: Mongo

beforeAll(async () => {
    mongo = await startMongo()
})

afterAll(async () => {
    mongo.stopMongo()
})

it('should add a new item', async () => {
    const item: ToDoListItem = getTestItem()

    const context = new InvocationContext()
    const request = new TestRequest({
        method: 'POST',
        body: { string: JSON.stringify(item) }
    })

    const response = await route.handler(request, context)

    expect(response).toEqual({
        jsonBody: {
            ...item,
            createdAt: expect.any(Date),
            updatedAt: expect.any(Date)
        }
    })
})