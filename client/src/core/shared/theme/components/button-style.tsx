import { LabComponents } from '@mui/lab/themeAugmentation'
import { Components } from '@mui/material/styles/components'
import { colorPalette } from '../color-palette'

declare module '@mui/material/Button' {
  interface ButtonPropsColorOverrides {
    red: true
  }
}

export const MuiButton: Components['MuiButton'] = {
  defaultProps: {
    type: 'button',
    variant: 'contained',
    disableElevation: true,
    disableTouchRipple: true
  },
  styleOverrides: {
    root: {
      borderRadius: '6px',
      textTransform: 'none',
      textWrap: 'nowrap',
      boxShadow: '0px 1px 2px 0px rgba(0, 0, 0, 0.07)',
      transition: 'all .1s ease-out',
      transitionProperty: 'border,background-color,color',
      '&.Mui-disabled': {
        opacity: 0.5
      },
      '&.MuiButton-sizeSmall': {
        svg: {
          height: '14px',
          width: '14px'
        }
      },
      '&.MuiButton-sizeMedium': {
        svg: {
          height: '16px',
          width: '16px'
        }
      },
      '&.MuiButton-sizeLarge': {
        svg: {
          height: '20px',
          width: '20px'
        }
      }
    },
    sizeSmall: {
      height: '24px',
      padding: '2px 8px',
      fontSize: '12px'
    },
    sizeMedium: {
      height: '32px',
      padding: '6px 12px',
      fontSize: '14px'
    },
    sizeLarge: {
      height: '40px',
      padding: '8px 16px',
      fontSize: '16px'
    }
  },
  variants: [
    {
      props: { variant: 'contained' },
      style: {
        boxShadow: 'none',
        color: colorPalette.grey2[600],
        background: colorPalette.grey2[100],
        '&.Mui-disabled': {
          color: colorPalette.grey2[600],
          background: colorPalette.common.white
        },
        '&:hover': {
          color: colorPalette.grey2[700],
          background: colorPalette.grey2[200]
        }
      }
    },
    {
      props: { variant: 'contained', color: 'red' },
      style: {
        boxShadow: 'none',
        color: colorPalette.common.white,
        background: colorPalette.red[500],
        '&.Mui-disabled': {
          color: colorPalette.common.white,
          background: colorPalette.red[500]
        },
        '&:hover': {
          color: colorPalette.common.white,
          background: colorPalette.red[600]
        }
      }
    }
  ]
}

export const MuiIconButton: Components['MuiIconButton'] = {
  defaultProps: {
    type: 'button',
    color: 'primary',
    disableRipple: true,
    disableTouchRipple: true
  },
  styleOverrides: {
    root: {
      borderRadius: '6px',
      textTransform: 'none',
      boxShadow: '0px 1px 2px 0px rgba(0, 0, 0, 0.07)',
      transition: 'all .1s ease-out',
      transitionProperty: 'border,background-color,color',
      '&.Mui-disabled': {
        opacity: 0.5
      },
      '&.MuiButton-sizeSmall': {
        svg: {
          height: '14px',
          width: '14px'
        },
      },
      '&.MuiButton-sizeMedium': {
        svg: {
          height: '16px',
          width: '16px'
        },
      },
      '&.MuiButton-sizeLarge': {
        svg: {
          height: '20px',
          width: '20px'
        },
      },
    },
    sizeSmall: {
      height: '24px',
      width: '24px',
      padding: '10px',
      fontSize: '12px'
    },
    sizeMedium: {
      height: '32px',
      width: '32px',
      padding: '8px',
      fontSize: '14px'
    },
    sizeLarge: {
      height: '40px',
      width: '40px',
      padding: '5px',
      fontSize: '16px'
    },
  },
  variants: [
    {
      props: { color: 'primary' },
      style: {
        color: colorPalette.grey2[600],
        background: colorPalette.grey2[50],
        '&.Mui-disabled': {
          color: colorPalette.grey2[600],
          background: colorPalette.common.white
        },
        '&:hover': {
          background: colorPalette.grey2[200]
        }
      }
    }
  ]
}

export const MuiLoadingButton: LabComponents['MuiLoadingButton'] = {
  defaultProps: {
    variant: 'contained'
  },
  styleOverrides: {
    root: {
      '&.MuiLoadingButton-loading': {
        color: `${colorPalette.common.white} !important`
      }
    }
  },
  variants: [
    {
      props: { variant: 'contained' },
      style: {
        boxShadow: 'none',
        color: colorPalette.grey2[600],
        background: colorPalette.grey2[100],
        '&.Mui-disabled': {
          color: colorPalette.grey2[600],
          background: colorPalette.common.white
        },
        '&:hover': {
          color: colorPalette.grey2[700],
          background: colorPalette.grey2[200]
        }
      }
    }
  ]
}
