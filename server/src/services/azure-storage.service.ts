import { BlobServiceClient, ContainerClient, RestError } from '@azure/storage-blob'
import { uuid } from 'common'

const CONTAINER_NAME = 'storage'

export class AzureStorageService {
    private storage: BlobServiceClient
    private container: ContainerClient

    constructor(connectionString?: string) {
        if (connectionString) {
            this.connect(connectionString)
        }
    }

    async connect(connectionString: string) {
        this.storage = BlobServiceClient.fromConnectionString(connectionString)

        const containerExists = await this.storage.getContainerClient(CONTAINER_NAME).exists()

        if (!containerExists) {
            await this.storage.createContainer(CONTAINER_NAME, { access: 'blob' })
        }

        this.container = this.storage.getContainerClient(CONTAINER_NAME)
    }

    async uploadFile(name: string, file: File) {
        const client = this.container.getBlockBlobClient(name)
        await client.uploadData(Buffer.from(await file.arrayBuffer()))

        return `/${CONTAINER_NAME}/${name}`
    }

    async uploadProfileImage(id: string, file: File) {
        const extension = file.name.slice(file.name.lastIndexOf('.'))
        return await this.uploadFile.bind(this)(`profile-image/${id}/${uuid()}${extension}`, file)
    }

    async deleteFile(fileName: string) {
        try {
            await this.container.deleteBlob(fileName.replace(`/${CONTAINER_NAME}/`, ''))
        } catch (error) {
            if ((error as RestError).statusCode === 404) {
                return
            }
            throw error
        }
    }
}