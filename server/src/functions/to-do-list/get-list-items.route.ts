import { ToDoListItem } from "common"
import { azureRoute } from "../../azure-route"
import { authenticate } from "../../middlewares/authenticate.middleware"
import { ToDoList } from "../../config"
import { app } from "@azure/functions"

export const route = azureRoute<ToDoListItem[]>({
    methods: ['GET'],
    route: 'todolist',
    middlewares: [authenticate()],
    handler: async (request, context) => {
        const listItems = await ToDoList.getAll()

        return { jsonBody: listItems }
    }
})

app.http('get-list-items', route)