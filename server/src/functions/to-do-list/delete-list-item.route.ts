import { azureRoute } from "../../azure-route"
import { authenticate } from "../../middlewares/authenticate.middleware"
import { ToDoList } from "../../config"
import { app } from "@azure/functions"
import { ItemNotFoundErrorResponse } from "../../error-response"

export const route = azureRoute({
    methods: ['DELETE'],
    route: 'todolist/{id}',
    middlewares: [authenticate()],
    handler: async (request, context) => {
        const { id } = request.params

        const listItem = await ToDoList.getById(id)

        if (!listItem) {
            throw new ItemNotFoundErrorResponse()
        }

        await ToDoList.delete(id)

        return { status: 200 }
    }
})

app.http('delete-list-item', route)