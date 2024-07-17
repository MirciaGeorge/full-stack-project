import { PaletteColor, PaletteColorOptions } from '@mui/material'

declare module '@mui/material/styles' {
  interface PaletteOptions {
    grey2: PaletteColorOptions
    blue: PaletteColorOptions
    teal: PaletteColorOptions
    red: PaletteColorOptions
    orange: PaletteColorOptions
  }
  interface Palette {
    grey2: PaletteColor
    blue: PaletteColor
    teal: PaletteColor
    red: PaletteColor
    orange: PaletteColor
  }
}

export const colorPalette = {
  common: {
    black: "#000",
    white: "#fff"
  },
  grey2: {
    50: "#fafafa",
    100: "#f5f5f5",
    200: "#eeeeee",
    300: "#e0e0e0",
    400: "#bdbdbd",
    500: "#9e9e9e",
    600: "#757575",
    700: "#616161",
    800: "#424242",
    900: "#212121",
    A100: "#f5f5f5",
    A200: "#eeeeee",
    A400: "#bdbdbd",
    A700: "#616161"
  },
  blue: {
    10: "#ecedf6",
    50: "#e3f2fd",
    100: "#bbdefb",
    200: "#90caf9",
    300: "#64b5f6",
    400: "#42a5f5",
    500: "#2196f3",
    600: "#1e88e5",
    700: "#1976d2",
    800: "#1565c0",
    900: "#11101d",
    A100: "#82b1ff",
    A200: "#448aff",
    A400: "#2979ff",
    A700: "#2962ff"
  },
  teal: {
    50: "#e0f2f1",
    100: "#b2dfdb",
    200: "#80cbc4",
    300: "#4db6ac",
    400: "#26a69a",
    500: "#009688",
    600: "#00897b",
    700: "#00796b",
    800: "#00695c",
    900: "#004d40",
    A100: "#a7ffeb",
    A200: "#64ffda",
    A400: "#1de9b6",
    A700: "#00bfa5"
  },
  red: {
    50: "#ffebee",
    100: "#ffcdd2",
    200: "#ef9a9a",
    300: "#e57373",
    400: "#ef5350",
    500: "#f44336",
    600: "#e53935",
    700: "#d32f2f",
    800: "#c62828",
    900: "#b71c1c",
    A100: "#ff8a80",
    A200: "#ff5252",
    A400: "#ff1744",
    A700: "#d50000"
  },
  orange: {
    50: "#fff3e0",
    100: "#ffe0b2",
    200: "#ffcc80",
    300: "#ffb74d",
    400: "#ffa726",
    500: "#ff9800",
    600: "#fb8c00",
    700: "#f57c00",
    800: "#ef6c00",
    900: "#e65100",
    A100: "#ffd180",
    A200: "#ffab40",
    A400: "#ff9100",
    A700: "#ff6d00"
  }
}
export const palette = {
  grey2: {
    light: colorPalette.grey2[300],
    main: colorPalette.grey2[500],
    dark: colorPalette.grey2[600],
    contrastText: colorPalette.grey2[500]
  },
  blue: {
    light: colorPalette.blue[300],
    main: colorPalette.blue[500],
    dark: colorPalette.blue[600],
    contrastText: colorPalette.blue[500]
  },
  teal: {
    light: colorPalette.teal[300],
    main: colorPalette.teal[500],
    dark: colorPalette.teal[600],
    contrastText: colorPalette.teal[500]
  },
  red: {
    light: colorPalette.red[300],
    main: colorPalette.red[500],
    dark: colorPalette.red[600],
    contrastText: colorPalette.red[500]
  },
  orange: {
    light: colorPalette.orange[300],
    main: colorPalette.orange[500],
    dark: colorPalette.orange[600],
    contrastText: colorPalette.orange[500]
  }
}

