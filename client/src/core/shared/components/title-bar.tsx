import { Box, Stack, Typography } from '@mui/material'
import { ReactNode } from 'react'
import { createSx } from '../../../types'
import { colorPalette } from '../theme/color-palette'

const styles = createSx({
  root: {
    display: 'flex',
    minHeight: '62px',
    height: '62px',
    width: '100%',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: colorPalette.common.white,
    borderBottom: '1px solid',
    borderColor: colorPalette.grey2[200],
    padding: '0px 24px',
    overflow: 'hidden'
  },
  title: {
    display: 'flex',
    width: '100%'
  }
})

interface Props {
  title?: string | ReactNode
  actions?: ReactNode
}

export function TitleBar({ title, actions }: Props) {
  return (
    <Box sx={styles.root}>
      <Box sx={styles.title}>
        {title && typeof title === 'string' ? (
          <Typography variant='h5' color={colorPalette.blue[900]}>
            {title}
          </Typography>
        ) : typeof title !== 'string' ? (
          title
        ) : (
          <div></div>
        )}
      </Box>
      <Stack direction='row' spacing={1}>
        {actions}
      </Stack>
    </Box>
  )
}
