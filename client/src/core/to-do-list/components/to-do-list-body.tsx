import { List } from "@mui/material"
import { createSx } from "../../../types"
import { useToDoList } from "../to-do-list-context"
import { ToDoListItemComponent } from "./to-do-list-item-component"
import { colorPalette } from "../../../core/shared/theme/color-palette"

const styles = createSx({
    root: {
        overflow: 'auto',
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        width: '100%',
        paddingTop: '10px',
        backgroundColor: colorPalette.blue[10]
    },
})

export function ToDoListBody() {
    const { toDoListItems } = useToDoList()

    return (
        <List sx={styles.root}>
            {toDoListItems && toDoListItems.map((item) => (
                <ToDoListItemComponent item={item} />
            ))}
        </List>
    )
}