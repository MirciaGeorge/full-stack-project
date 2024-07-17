import { Box } from '@mui/material'
import { ReactNode } from 'react'
import { createSx } from '../../../types'
import { TitleBar } from '../components/title-bar'

const styles = createSx({
    root: {
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        width: '100%'
    }
})

interface Props {
    title: string
    actions?: ReactNode
    children?: ReactNode
}

export function BasePage({ title, actions, children }: Props) {
    return (
        <Box sx={styles.root}>
            <TitleBar title={title} actions={actions} />
            {children}
        </Box>
    )
}
