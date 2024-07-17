import Joi, { Schema } from "joi"
import { AzureHttpHandler } from "../azure-route"
import { HttpRequest, InvocationContext } from "@azure/functions"
import { ValidationErrorResponse } from "../error-response"
import { defaultJoiOptions } from "../utils"

export function validateBody(schema: Schema, joiOptions?: Joi.ValidationOptions) {
    return (handler: AzureHttpHandler): AzureHttpHandler =>
        async (request: HttpRequest, context: InvocationContext) => {
            const body = await request.json()

            const { error, value } = schema.validate(body, { ...defaultJoiOptions, ...joiOptions })

            if (error) {
                throw new ValidationErrorResponse(error)
            }

            request.payload = value

            return handler(request, context)
        }
}