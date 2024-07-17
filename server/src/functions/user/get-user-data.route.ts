import { app } from "@azure/functions";
import { UserData } from "common";
import { azureRoute } from "../../azure-route";
import { User } from "../../config";
import { authenticate } from "../../middlewares/authenticate.middleware";

export const route = azureRoute<UserData>({
    methods: ['GET'],
    route: 'user/{id}',
    middlewares: [authenticate()],
    handler: async (request, context) => {
        const { id } = request.params

        const user = await User.getById(id) ?? { id, profileImageUrl: '' }

        return { jsonBody: user }
    }
})

app.http('get-user-data', route)