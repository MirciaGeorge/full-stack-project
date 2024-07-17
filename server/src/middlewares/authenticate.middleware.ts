import { HttpRequest, InvocationContext } from "@azure/functions"
import { AzureHttpHandler } from "../azure-route"
import { UnauthorizedErrorResponse } from "../error-response"
import { Keycloak } from "../config"
import { RealmRole } from "common"
import { setUser as setSentryUser } from '@sentry/node'

export function authenticate() {
    return (handler: AzureHttpHandler): AzureHttpHandler =>
        async (request: HttpRequest, context: InvocationContext) => {
            const token = request.headers.get('authorization')?.split(' ')[1]

            if (!token) {
                throw new UnauthorizedErrorResponse()
            }

            const data = await Keycloak.introspect(token)

            if (!data.realm_access?.roles?.includes(RealmRole.admin)) {
                throw new UnauthorizedErrorResponse()
            }

            request.User = {
                sub: data.sub,
                name: data.name,
                email: data.email,
                username: data.username,
                roles: data.realm_access.roles,
            }

            setSentryUser({ id: data.sub, email: data.email })

            return handler(request, context)
        }
}