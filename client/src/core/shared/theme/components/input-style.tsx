import { Components } from '@mui/material/styles/components'
import { colorPalette } from '../color-palette'

export const MuiOutlinedInput: Components['MuiOutlinedInput'] = {
  styleOverrides: {
    root: {
      color: colorPalette.grey2[900],
      height: '32px',
      fieldset: {
        boxShadow: '0px 1px 2px 0px rgba(0, 0, 0, 0.05)',
        border: '1px solid',
        borderColor: colorPalette.grey2[200],
        borderRadius: '7px',
        transition: '.1s ease-out'
      },
      input: {
        padding: '8px 12px'
      },
      '&:hover .MuiOutlinedInput-notchedOutline': {
        borderColor: colorPalette.grey2[300]
      },
      '&.Mui-focused': {
        '.MuiOutlinedInput-notchedOutline': {
          border: '1px solid',
          borderColor: colorPalette.blue[500],
          boxShadow: '0 0 0 3px rgba(54, 178, 181, 0.13)'
        }
      }
    },
    sizeSmall: {
      input: {
        fontSize: '14px',
        padding: '6px 12px'
      }
    }
  }
}

export const MuiTextField: Components['MuiTextField'] = {
  defaultProps: {
    hiddenLabel: true,
    variant: 'outlined',
    InputLabelProps: {
      shrink: false
    },
  },
  styleOverrides: {
    root: {
      height: '32px'
    }
  }
}

export const MuiCheckbox: Components['MuiCheckbox'] = {
  styleOverrides: {
    root: {
      height: '20px',
      width: '20px',
      color: colorPalette.grey2[400],
      '&:hover': {
        color: colorPalette.grey2[400]
      },
      '&.Mui-checked': {
        color: colorPalette.blue[500],
        '&:hover': {
          color: colorPalette.blue[500]
        },
      },
      '&.Mui-disabled': {
        color: colorPalette.grey2[200]
      },
      svg: {
        fontSize: '18px'
      }
    }
  }
}

export const MuiFormControlLabel: Components['MuiFormControlLabel'] = {
  defaultProps: {
    color: 'primary'
  },
  styleOverrides: {
    root: {
      marginLeft: 0
    },
    label: {
      fontSize: '14px',
      marginLeft: '8px'
    }
  }
}

export const MuiFormGroup: Components['MuiFormGroup'] = {
  styleOverrides: {
    root: {
      marginBottom: '16px'
    }
  }
}

export const MuiFormLabel: Components['MuiFormLabel'] = {
  styleOverrides: {
    root: {
      lineHeight: '20px',
      fontSize: '14px',
      fontWeight: 500,
      marginBottom: '8px'
    }
  }
}
