import { ToDoListItem, ToDoListItemStatus } from 'common'
import { BaseMongoService } from './base-mongo-service'
import mongoose from 'mongoose'
import { ToDoListNotFoundErrorResponse } from '../error-response'


export class ToDoListService extends BaseMongoService<ToDoListItem> {
    constructor(connectionString?: string) {
        super({
            connectionString,
            collectionName: 'Items',
            schema: new mongoose.Schema(
                {
                    id: { type: String, immutable: true },
                    name: { type: String, required: true },
                    status: { type: String, default: ToDoListItemStatus.UNFINISHED, enum: Object.values(ToDoListItemStatus) }
                },
                { timestamps: true }
            ),
            resourceNotFoundErrorResponse: ToDoListNotFoundErrorResponse
        })
    }
}