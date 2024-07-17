import { ApiServiceClientOptions } from "./api-service-client";
import { ToDoListApiServiceClient } from "./to-do-list-api-service-client";
import { UserApiServiceClient } from "./user-api-service-client";

export class MainApiServiceClient {
    public toDoList: ToDoListApiServiceClient
    public user: UserApiServiceClient

    constructor(basePath: string, options: ApiServiceClientOptions = {}) {
        this.toDoList = new ToDoListApiServiceClient(basePath, options)
        this.user = new UserApiServiceClient(basePath, options)
    }
}