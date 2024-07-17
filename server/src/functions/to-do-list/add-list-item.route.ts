import { ToDoListItem, toDoListItemSchema } from "common"
import { azureRoute } from "../../azure-route"
import { authenticate } from "../../middlewares/authenticate.middleware"
import { ToDoList } from "../../config"
import { app } from "@azure/functions"
import { validateBody } from "../../middlewares/validate-body.middlewares"

export const route = azureRoute<ToDoListItem, ToDoListItem>({
    methods: ['POST'],
    route: 'todolist',
    middlewares: [authenticate(), validateBody(toDoListItemSchema)],
    handler: async (request, context) => {
        const { payload } = request

        const newListItem = await ToDoList.add(payload)

        return { jsonBody: newListItem }
    }
})

app.http('add-list-item', route)