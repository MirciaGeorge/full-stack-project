import { ReactNode } from "react"
import { createSx } from "../../../../types"
import { colorPalette } from "../../theme/color-palette"
import { Box, Grid, Typography } from "@mui/material"

const styles = createSx({
    root: {
        display: 'flex',
        alignItems: 'center',
        borderBottom: '1px solid',
        borderColor: colorPalette.grey2[200],
        padding: '16px 0px',
    },
    left: {
        display: 'flex',
        flexDirection: 'column',
        paddingRight: 2,
    },
    right: {
        display: 'flex',
        '.MuiFormControl-root': {
            width: '100%',
        },
        textarea: {
            width: '100%',
        },
    }
})

export interface CustomFieldProps {
    text: string | ReactNode
    input: ReactNode
}

export function CustomField({
    text,
    input,

}: CustomFieldProps) {
    return (
        <Grid container sx={styles.root}>
            <Grid item xs={6} sx={styles.left}>
                <Box sx={{ display: 'flex', alignItems: 'center' }}>
                    <Box>
                        <Typography variant='subtitle2'>{text}</Typography>
                    </Box>
                </Box>
            </Grid>
            {input ? (
                <Grid item xs={6} sx={styles.right}>
                    {input}
                </Grid>
            ) : null}
        </Grid>
    )
}