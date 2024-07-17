import { ToDoListItem, toDoListItemUpdateSchema } from "common"
import { azureRoute } from "../../azure-route"
import { authenticate } from "../../middlewares/authenticate.middleware"
import { ToDoList } from "../../config"
import { app } from "@azure/functions"
import { validateBody } from "../../middlewares/validate-body.middlewares"
import { ItemNotFoundErrorResponse } from "../../error-response"

export const route = azureRoute<ToDoListItem, ToDoListItem>({
    methods: ['PATCH'],
    route: 'todolist/{id}',
    middlewares: [authenticate(), validateBody(toDoListItemUpdateSchema)],
    handler: async (request, context) => {
        const { id } = request.params
        const { payload } = request

        const listItem = await ToDoList.getById(id)

        if (!listItem) {
            throw new ItemNotFoundErrorResponse()
        }

        const patchedItem = await ToDoList.update(id, payload)

        return { jsonBody: patchedItem }
    }
})

app.http('patch-list-item', route)