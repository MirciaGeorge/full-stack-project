import { ApiServiceClient, ApiServiceClientOptions } from "./api-service-client";

export class UserApiServiceClient extends ApiServiceClient {
    constructor(basePath: string, options: ApiServiceClientOptions = {}) {
        super(basePath, options, '/user')
    }

    async uploadProfileImage(image: File): Promise<string> {
        const formData = new FormData()
        formData.append('file', image)

        const response = await this.http({
            url: `${this.route}/image`,
            headers: { 'Content-Type': 'multipart/form-data' },
            method: 'POST',
            data: formData,
        })

        return response.data
    }

    async deleteProfileImage(): Promise<void> {
        await this.http.delete(`${this.route}/image`)
    }
}