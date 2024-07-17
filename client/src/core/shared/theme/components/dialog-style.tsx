import { Components } from '@mui/material/styles/components'
import { colorPalette } from '../color-palette'

export const MuiDialog: Components['MuiDialog'] = {
  styleOverrides: {
    paper: {
      maxWidth: 'unset',
      backgroundColor: colorPalette.common.white,
      border: '1px solid',
      borderColor: 'rgba(12, 13, 13, 0.04)',
      borderRadius: '16px',
      boxShadow: '0px 11px 11px -5px rgba(0, 0, 0, 0.05), 0px 20px 25px -5px rgba(0, 0, 0, 0.10)'
    }
  }
}

export const MuiDialogContent: Components['MuiDialogContent'] = {
  styleOverrides: {
    root: {
      padding: '24px 24px 0px'
    }
  }
}

export const MuiDialogContentText: Components['MuiDialogContentText'] = {
  styleOverrides: {
    root: {
      fontSize: '14px',
      fontWeight: 400,
      lineHeight: '20px'
    }
  }
}

export const MuiDialogTitle: Components['MuiDialogTitle'] = {
  defaultProps: {
    color: colorPalette.blue[900],
    variant: 'h5',
    marginBottom: '0px'
  },
  styleOverrides: {
    root: {
      padding: '16px 24px'
    }
  }
}

export const MuiDialogActions: Components['MuiDialogActions'] = {
  styleOverrides: {
    root: {
      padding: '24px'
    }
  }
}