import { Components } from '@mui/material/styles/components'

export const MuiTooltip: Components['MuiTooltip'] = {
  defaultProps: {
    placement: 'bottom',
  },
  styleOverrides: {
    tooltip: {
      fontSize: '12px',
    },
    popper: {
      whiteSpace: 'pre-wrap',
    }
  }
}
