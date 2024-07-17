import { HttpResponseInit } from '@azure/functions'
import { ValidationError } from 'joi'

export class ErrorResponse extends Error {
    status: number
    details: any
    isErrorResponse = true

    constructor(message: string, status: number, details?: any) {
        super(message)
        this.status = status
        this.details = details
    }

    toHttpResponse(eventId: string): HttpResponseInit {
        return {
            status: this.status,
            jsonBody: {
                timestamp: new Date(),
                message: this.message,
                details: this.details,
                eventId
            }
        }
    }
}

export class ResourceNotFoundErrorResponse extends ErrorResponse {
    constructor(message?: string) {
        super(message || 'Resource not found', 404)
    }
}

export class InternalErrorResponse extends ErrorResponse {
    constructor() {
        super('Internal error', 500)
    }
}

export class ValidationErrorResponse extends ErrorResponse {
    constructor(error: ValidationError) {
        super('Validation error', 422, error.details)
    }
}

export class UnauthorizedErrorResponse extends ErrorResponse {
    constructor() {
        super('Unauthorized', 401)
    }
}

export class UserNotFoundErrorResponse extends ResourceNotFoundErrorResponse {
    constructor() {
        super('User not found')
    }
}

export class ItemNotFoundErrorResponse extends ResourceNotFoundErrorResponse {
    constructor() {
        super('Item not found')
    }
}

export class ToDoListNotFoundErrorResponse extends ResourceNotFoundErrorResponse {
    constructor() {
        super('To do list not found')
    }
}