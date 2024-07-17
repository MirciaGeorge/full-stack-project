import { app } from "@azure/functions";
import { azureRoute } from "../../azure-route";
import { AzureStorage, User } from "../../config";
import { UserNotFoundErrorResponse } from "../../error-response";
import { authenticate } from "../../middlewares/authenticate.middleware";

export const route = azureRoute({
    methods: ['DELETE'],
    route: 'user/image',
    middlewares: [authenticate()],
    handler: async (request, context) => {
        const { User: { sub } } = request

        const userData = await User.getById(sub)

        if (!userData) {
            throw new UserNotFoundErrorResponse
        }

        await AzureStorage.deleteFile(userData.profileImageUrl)
        await User.removeProfileImage(sub)

        return { status: 200 }
    }
})

app.http('delete-profile-image', route)