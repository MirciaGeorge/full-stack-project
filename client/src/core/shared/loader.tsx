import { Box, CircularProgress } from '@mui/material'

export function Loader() {
  return (
    <Box sx={{
      height: '100%',
      width: '100%',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center'
    }}>
      <CircularProgress />
    </Box>
  )
}
