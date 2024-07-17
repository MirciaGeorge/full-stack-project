import { HttpRequest, InvocationContext } from "@azure/functions"
import { AzureHttpHandler } from "../azure-route"
import { uuid } from 'common'
import { ErrorResponse, InternalErrorResponse } from "../error-response"
import { captureException, flush, withScope } from '@sentry/node'

export function errorHandler(handler: AzureHttpHandler): AzureHttpHandler {
    return async (request: HttpRequest, context: InvocationContext) => {
        request.eventId = uuid()
        
        return Promise.resolve(handler(request, context)).catch(async error => {
            withScope(scope => {
                scope.setSDKProcessingMetadata({ request })
                captureException(error, { event_id: request.eventId })
            })
            await flush(2000)

            if (error instanceof ErrorResponse) {
                return error.toHttpResponse(request.eventId)
            }

            return new InternalErrorResponse().toHttpResponse(request.eventId)
        })
    }
}