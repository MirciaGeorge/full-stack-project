
import { ToDoListItem } from 'common'
import { ApiServiceClient, ApiServiceClientOptions } from './api-service-client'

export class ToDoListApiServiceClient extends ApiServiceClient<ToDoListItem> {
    constructor(basePath: string, options: ApiServiceClientOptions = {}) {
        super(basePath, options, '/todolist')
    }
}