import Joi from "joi"
import { ToDoListItem, ToDoListItemStatus } from "./to-do-list-types"

export const toDoListItemSchema = Joi.object<ToDoListItem>({
    id: Joi.string().guid({ version: 'uuidv4' }).required(),
    name: Joi.string().required(),
    status: Joi.string()
        .valid(...Object.values(ToDoListItemStatus))
        .optional(),
})

export const toDoListItemUpdateSchema = Joi.object<ToDoListItem>({
    id: Joi.string().guid({ version: 'uuidv4' }).optional(),
    name: Joi.string().optional(),
    status: Joi.string()
        .valid(...Object.values(ToDoListItemStatus))
        .optional(),
})