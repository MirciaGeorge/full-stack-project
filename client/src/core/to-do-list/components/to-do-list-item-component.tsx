import { Box, Checkbox, IconButton, ListItem } from "@mui/material"
import { createSx } from "../../../types"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faCheck, faPen, faTrash, faXmark } from "@fortawesome/free-solid-svg-icons"
import { colorPalette } from "../../../core/shared/theme/color-palette"
import { useEffect, useState } from "react"
import { CustomTextField } from "../../../core/shared/components/inputs/custom-text-field"
import { ToDoListItem, ToDoListItemStatus } from "common"
import { useToDoList } from "../to-do-list-context"

const styles = createSx({
    root: {
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        width: 'calc(100% - 40px)',
        padding: '10px',
        margin: '10px 20px',
        backgroundColor: colorPalette.common.white,
        borderRadius: '5px'
    },
    content: (isFinished: boolean) => ({
        position: 'relative',
        margin: '0px 5px',
        ...(isFinished && {
            '::after': {
                content: '""',
                position: 'absolute',
                top: '50%',
                left: 0,
                width: '100%',
                height: '1px',
                backgroundColor: colorPalette.grey2[900],
                transform: 'translateY(-50%)'
            }
        })
    }),
    actions: {
        width: '100%',
        display: 'flex',
        justifyContent: 'flex-end',
        gap: '10px'
    }
})

interface Props {
    item: ToDoListItem
}

export function ToDoListItemComponent({ item }: Props) {
    const { patchToDoListItem, deleteToDoListItem } = useToDoList()
    const [editModeActive, setEditModeActive] = useState(false)
    const [checked, setChecked] = useState(false)

    async function onSave(newName: string) {
        await patchToDoListItem(item.id, { name: newName })
        setEditModeActive(false)
    }

    async function onCheck(check: boolean) {
        await patchToDoListItem(item.id, { status: check ? ToDoListItemStatus.FINISHED : ToDoListItemStatus.UNFINISHED })
        setChecked(check)
    }

    useEffect(() => {
        setChecked(item.status === ToDoListItemStatus.FINISHED)
    }, [item])

    return (
        <ListItem key={item.id} sx={styles.root}>
            <Checkbox
                checked={checked}
                disabled={editModeActive}
                onChange={({ target }) => onCheck(target.checked)}
            />
            {editModeActive ?
                <EditMode
                    name={item.name}
                    onSave={newName => onSave(newName)}
                    setEditModeActive={setEditModeActive}
                />
                : <DisplayMode
                    name={item.name}
                    checked={checked}
                    onDelete={() => deleteToDoListItem(item.id)}
                    setEditModeActive={setEditModeActive}
                />
            }
        </ListItem>
    )
}

interface EditModeProps {
    name: string
    onSave: (newName: string) => void
    setEditModeActive: (value: boolean) => void
}

function EditMode({ name, onSave, setEditModeActive }: EditModeProps) {
    const [newName, setNewName] = useState(name)

    return (
        <>
            <Box sx={styles.content(false)}>
                <CustomTextField value={newName} onChange={({ target }) => setNewName(target.value)} />
            </Box>

            <Box sx={styles.actions}>
                <IconButton onClick={() => setEditModeActive(false)}>
                    <FontAwesomeIcon size="xl" icon={faXmark} />
                </IconButton>
                <IconButton disabled={newName === name || !newName} onClick={() => onSave(newName)}>
                    <FontAwesomeIcon size="xl" icon={faCheck} />
                </IconButton>
            </Box>
        </>
    )

}

interface DisplayModeProps {
    name: string
    checked: boolean
    onDelete: () => void
    setEditModeActive: (value: boolean) => void
}

function DisplayMode({ name, checked, onDelete, setEditModeActive }: DisplayModeProps) {
    return (
        <>
            <Box sx={styles.content(checked)}>{name}</Box>

            <Box sx={styles.actions}>
                <IconButton onClick={onDelete}>
                    <FontAwesomeIcon icon={faTrash} />
                </IconButton>
                <IconButton disabled={checked} onClick={() => setEditModeActive(true)}>
                    <FontAwesomeIcon icon={faPen} />
                </IconButton>
            </Box>
        </>
    )
}