import { MongoMemoryServer } from 'mongodb-memory-server'
import { ToDoList, User } from '../config'
import mongoose from 'mongoose'
import { HttpRequest, HttpRequestInit } from '@azure/functions'
import { KeycloakTokenPayload, RealmRole, ToDoListItem, ToDoListItemStatus, UserData, uuid } from 'common'

export type Mongo = Awaited<ReturnType<typeof startMongo>>

const testUser: KeycloakTokenPayload = {
    sub: '66bbcbd9-0933-4ae9-ba56-6cd9ae58c19d',
    name: 'Astarion Ancunin',
    email: 'user@app.com',
    username: 'username',
    realm_access: {
        roles: [RealmRole.admin]
    }
}

export async function startMongo() {
    const mongoServer = await MongoMemoryServer.create()

    const services = [
        ToDoList,
        User
    ]

    await Promise.all(services.map(service => service.connect(mongoServer.getUri())))

    async function stopMongo() {
        await Promise.all([
            mongoose.connection.close(),
            mongoServer.stop()
        ])
    }

    return { mongoServer, stopMongo }
}

export class TestRequest extends HttpRequest {
    constructor(httpRequestInit: HttpRequestInit = {}) {
        super({
            ...httpRequestInit,
            url: `http://localhost/${httpRequestInit.url}`,
            headers: { authorization: `Bearer ${encodeURIComponent(JSON.stringify(testUser))}` }
        })
    }
}

export function getTestItem(): ToDoListItem {
    return {
        id: uuid(),
        name: 'Test name',
        status: ToDoListItemStatus.UNFINISHED
    }
}

export function getUserData(): UserData {
    return {
        id: uuid(),
        profileImageUrl: 'test url'
    }
}