import { Components } from '@mui/material/styles/components'
import { colorPalette } from '../color-palette'

export const MuiAlert: Components['MuiAlert'] = {
  styleOverrides: {
    root: {
      padding: '12px',
      border: '1px solid',
      borderRadius: '12px',
      '.MuiAlert-message': {
        padding: '6px 13px'
      },
      '.MuiAlert-icon': {
        padding: '8px',
        margin: 0,
        color: 'unset',
        svg: {
          height: '18px',
          width: '18px'
        }
      }
    }
  },
  variants: [
    {
      props: { severity: 'info' },
      style: {
        color: colorPalette.blue[500],
        borderColor: colorPalette.blue[100],
        backgroundColor: colorPalette.blue[50]
      }
    },
    {
      props: { severity: 'success' },
      style: {
        color: colorPalette.teal[500],
        borderColor: colorPalette.teal[100],
        backgroundColor: colorPalette.teal[50]
      }
    },
    {
      props: { severity: 'warning' },
      style: {
        color: colorPalette.orange[500],
        borderColor: colorPalette.orange[100],
        backgroundColor: colorPalette.orange[50]
      }
    },
    {
      props: { severity: 'error' },
      style: {
        color: colorPalette.red[500],
        borderColor: colorPalette.red[100],
        backgroundColor: colorPalette.red[50]
      }
    }
  ]
}