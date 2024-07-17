import { Box, Typography } from '@mui/material'
import { ReactNode, useEffect } from 'react'
import { useTranslation } from 'react-i18next'
import { useLocation, useNavigate } from 'react-router-dom'
import { createSx } from '../../../types'
import { colorPalette } from '../theme/color-palette'

const styles = createSx({
  root: {
    display: 'flex',
    alignContent: 'center',
    flexDirection: 'column',
    flexWrap: 'wrap',
    textAlign: 'center',
    padding: '160px 80px 80px',
    width: '100%'
  },
  content: {
    width: '550px',
    whiteSpace: 'pre-wrap'
  },
  title: {
    mb: 2,
    fontSize: '80px',
    lineHeight: '90px',
    fontWeight: 500,
    color: colorPalette.blue[700]
  },
  message: {
    mb: 2,
    fontWeight: 400,
    color: colorPalette.grey2[500]
  }
})

interface Props {
  title?: string
  message?: ReactNode
}

export function ErrorPage({ title, message }: Props) {
  const { t } = useTranslation()

  return (
    <Box sx={styles.root}>
      <Box sx={styles.content}>
        <Typography sx={styles.title} >
          {title || t('error-page.title')}
        </Typography>
        <Typography sx={styles.message} variant='h6'>
          {message || t('error-page.default-error.title')}
        </Typography>
      </Box>
    </Box>
  )
}

export function NotFoundPage() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const location = useLocation()

  useEffect(() => {
    if (location.pathname !== '/404') {
      navigate('/404')
    }
    setTimeout(() => navigate('/'), 5000)
  }, [])

  return <ErrorPage title='404' message={t('page-not-found')} />
}
