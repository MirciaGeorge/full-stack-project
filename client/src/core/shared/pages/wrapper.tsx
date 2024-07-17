import { Box, Theme, useMediaQuery } from '@mui/material'
import { useEffect, useState } from 'react'
import { useLocation, useNavigate, useOutlet } from 'react-router-dom'
import { LocalStorage } from '../../../local-storage'
import { createSx } from '../../../types'
import { SIDEBAR_OPENED_WIDTH, SIDEBAR_CLOSED_WIDTH, Sidebar, sidebarTransition } from '../components/sidebar'
import { TO_DO_LIST_ROUTE } from '../../to-do-list/pages/to-do-list-page'

const styles = createSx({
  root: {
    height: '100%',
    width: '100%',
    display: 'flex',
    overflow: 'auto'
  },
  outlet: (sidebarCollapsed: boolean) => ({
    display: 'flex',
    height: '100%',
    width: sidebarCollapsed ? `calc(100% - ${SIDEBAR_OPENED_WIDTH}px)` : `calc(100% - ${SIDEBAR_CLOSED_WIDTH}px)`,
    transition: sidebarTransition
  })
})

export function Wrapper() {
  const { getSidebarCollapsed } = LocalStorage
  const lg = useMediaQuery((theme: Theme) => theme.breakpoints.up('lg'))
  const [open, setOpen] = useState(lg && !getSidebarCollapsed())
  const outlet = useOutlet()
  const navigate = useNavigate()
  const location = useLocation()

  useEffect(() => {
    if (location.pathname === '/') {
      navigate(`/${TO_DO_LIST_ROUTE}`)
      return
    }
  }, [location])

  return (
    <Box sx={styles.root}>
      <Sidebar open={open} setOpen={setOpen} />
      <Box sx={styles.outlet(open)}>{outlet}</Box>
    </Box>
  )
}
