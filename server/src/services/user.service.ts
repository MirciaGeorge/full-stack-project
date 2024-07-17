import { UserData } from "common";
import { BaseMongoService } from "./base-mongo-service";
import mongoose from "mongoose";
import { UserNotFoundErrorResponse } from "../error-response";

export class UserService extends BaseMongoService<UserData> {
    constructor(connectionString?: string) {
        super({
            connectionString,
            collectionName: 'Users',
            schema: new mongoose.Schema(
                {
                    id: { type: String, immutable: true },
                    profileImageUrl: { type: String }
                },
                { timestamps: true }
            ),
            resourceNotFoundErrorResponse: UserNotFoundErrorResponse
        })
    }

    async removeProfileImage(id: string) {
        await this.model.updateOne({ id }, { $unset: { profileImageUrl: '' } })
    }
}