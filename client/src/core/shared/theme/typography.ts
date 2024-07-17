import { TypographyOptions } from '@mui/material/styles/createTypography'
import { colorPalette } from './color-palette'

export const h1: TypographyOptions['h1'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '40px',
  fontSize: '36px',
  fontWeight: 700,
}

export const h2: TypographyOptions['h2'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '36px',
  fontSize: '30px',
  fontWeight: 700,
}

export const h3: TypographyOptions['h3'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '32px',
  fontSize: '24px',
  fontWeight: 700,
}

export const h4: TypographyOptions['h4'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '28px',
  fontSize: '20px',
  fontWeight: 600,
}

export const h5: TypographyOptions['h5'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '28px',
  fontSize: '18px',
  fontWeight: 600,
  marginBottom: '4px',
}

export const h6: TypographyOptions['h6'] = {
  color: colorPalette.blue[900],
  fontFamily: 'Inter',
  lineHeight: '24px',
  fontSize: '16px',
  fontWeight: 600,
}

export const subtitle1: TypographyOptions['subtitle1'] = {
  color: colorPalette.blue[900],
  lineHeight: '28px',
  fontSize: '18px',
  fontWeight: 400,
}

export const subtitle2: TypographyOptions['subtitle2'] = {
  color: colorPalette.blue[900],
  lineHeight: '20px',
  fontSize: '14px',
  fontWeight: 500,
}

export const button = {
  fontWeight: 600,
}

export const typography: TypographyOptions = {
  fontFamily: 'Inter, sans-serif',
  allVariants: {
    fontFamily: 'Inter, sans-serif',
    color: colorPalette.blue[900],
  },
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  subtitle1,
  subtitle2,
  button,
}
