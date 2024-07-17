export enum ToDoListItemStatus {
    FINISHED = "FINISHED",
    UNFINISHED = "UNFINISHED"
}

export type ToDoListItem = {
    id: string,
    name: string,
    status: ToDoListItemStatus
}