import { app } from "@azure/functions";
import { azureRoute } from "../../azure-route";
import { AzureStorage, User } from "../../config";
import { authenticate } from "../../middlewares/authenticate.middleware";

export const route = azureRoute({
    methods: ['POST'],
    route: 'user/image',
    middlewares: [authenticate()],
    handler: async (request, context) => {
        const { User: { sub } } = request

        const file = (await request.formData()).get('file') as any as File
        const profileImageUrl = await AzureStorage.uploadProfileImage(sub, file)

        await User.update(sub, { profileImageUrl })

        return { jsonBody: profileImageUrl }
    }
})

app.http('upload-profile-image', route)