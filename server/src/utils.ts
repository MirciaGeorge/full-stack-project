import { AsyncValidationOptions } from "joi"

export const defaultJoiOptions: AsyncValidationOptions = {
    abortEarly: false,
    stripUnknown: true,
    convert: true
}