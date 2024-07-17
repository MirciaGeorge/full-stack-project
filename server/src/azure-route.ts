import { HttpFunctionOptions, HttpRequest, InvocationContext } from '@azure/functions'
import { errorHandler } from './middlewares/error-handler.middleware'
import { TokenPayload } from 'common'

declare module '@azure/functions' {
  interface HttpRequest<T = any> {
    eventId: string
    debug: boolean
    User: TokenPayload
    payload: T
  }
}

export type AzureHttpHandler<Response = any, Payload = any> = (
  request: HttpRequest<Payload>,
  context: InvocationContext
) => Promise<{ jsonBody?: Response; status?: number }>

interface Options<Response, Payload> extends HttpFunctionOptions {
  middlewares?: ((handler: AzureHttpHandler<Response, Payload>) => AzureHttpHandler<Response, Payload>)[]
  handler: AzureHttpHandler<Response, Payload>
}

export function azureRoute<Response = any, Payload = any>({ middlewares = [], handler, ...options }: Options<Response, Payload>) {
  return {
    ...options,
    handler: errorHandler(middlewares.reduceRight((acc, current) => current(acc), handler)
    )
  }
}
