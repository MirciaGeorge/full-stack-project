
import { ToDoListItem } from 'common'
import { getTestItem, Mongo, startMongo, TestRequest } from '../test-utils'
import { InvocationContext } from '@azure/functions'
import { ToDoList } from '../../config'
import { route } from '../../functions/to-do-list/delete-list-item.route'

let mongo: Mongo

beforeAll(async () => {
    mongo = await startMongo()
})

afterAll(async () => {
    mongo.stopMongo()
})

it('should delete the item', async () => {
    const item: ToDoListItem = await ToDoList.add(getTestItem())

    const context = new InvocationContext()
    const request = new TestRequest({
        method: 'DELETE',
        params: { id: item.id }
    })

    const response = await route.handler(request, context)

    expect(response).toEqual({ status: 200 })
})