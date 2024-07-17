import { Dispatch, SetStateAction, useEffect, useMemo } from 'react'
import { LocalStorage } from '../../../local-storage'
import { Box, Button, CSSObject, Drawer, IconButton, IconButtonProps, Stack, Theme, Tooltip, useMediaQuery } from '@mui/material'
import { useTranslation } from 'react-i18next'
import { faArrowRightFromBracket, faBars, faGear, faListUl } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { createSx } from '../../../types'
import { colorPalette } from '../theme/color-palette'
import { useLocation, useNavigate } from 'react-router-dom'
import { TO_DO_LIST_ROUTE } from '../../to-do-list/pages/to-do-list-page'
import { useAuth } from '../../../core/auth/auth-context'
import { USER_PROFILE_ROUTE } from '../../../core/user-profile/pages/user-profile-page'

export const SIDEBAR_OPENED_WIDTH = 220
export const SIDEBAR_CLOSED_WIDTH = 65
export const sidebarTransition = '0.85s all cubic-bezier(.27, 1, .31, 1)'

const styles = createSx({
    root: (open: boolean) => ({
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'space-between',
        height: '500px',
        width: SIDEBAR_OPENED_WIDTH,
        color: colorPalette.common.white,
        flexShrink: 0,
        whiteSpace: 'nowrap',
        boxSizing: 'border-box',
        overflow: 'visible',
        zIndex: 1000,

        ...(open && {
            ...openedSidebar(),
            '& .MuiDrawer-paper': openedSidebar()
        }),
        ...(!open && {
            ...closedSidebar(),
            '& .MuiDrawer-paper': closedSidebar()
        }),

        '.MuiPaper-root': {
            overflow: 'visible'
        },
        '&:hover': {
            '.toggle': {
                opacity: 0.8
            }
        }
    }),
    toggle: {
        overflow: 'hidden',
        position: 'absolute',
        top: 0,
        left: 0,
        width: 'calc(100% + 20px)',
        height: '100%',
        '.toggle': {
            opacity: 0,
            backgroundColor: colorPalette.blue[50],
            transition: sidebarTransition
        }
    },
    toggleIcon: {
        height: '28px',
        width: '28px',
        borderRadius: 50,
        zIndex: 2000
    },
    toggleContainer: {
        position: 'absolute',
        top: 140,
        right: 5
    },
    linksContainer: {
        overflow: 'hidden',
        mb: 2
    },
    link: (active: boolean, open: boolean) => ({
        display: 'flex',
        alignItems: 'center',
        height: '40px',
        lineHeight: '24px',
        fontSize: '14px',
        borderRadius: '6px',
        backgroundColor: active ? colorPalette.common.white : colorPalette.blue[900],
        color: active ? colorPalette.common.black : colorPalette.common.white,
        padding: '8px 12px',
        cursor: 'pointer',
        '&:hover': {
            backgroundColor: active ? colorPalette.common.white : colorPalette.grey2[600]
        },
        svg: {
            overflow: 'visible',
            height: '18px',
            width: '18px'
        },
        '.link': {
            opacity: open ? 1 : 0,
            transition: 'opacity 0.5s'
        }
    })
})

const openedSidebar = (): CSSObject => ({
    backgroundColor: colorPalette.blue[900],
    color: colorPalette.common.white,
    padding: '10px',
    height: '100%',
    transform: 'scale(1)',
    transition: sidebarTransition,
    width: SIDEBAR_OPENED_WIDTH
})

const closedSidebar = (): CSSObject => ({
    backgroundColor: colorPalette.blue[900],
    color: colorPalette.common.white,
    padding: '10px',
    height: '100%',
    transform: 'scale(1)',
    transition: sidebarTransition,
    width: SIDEBAR_CLOSED_WIDTH
})

interface Props {
    open: boolean
    setOpen: Dispatch<SetStateAction<boolean>>
}

interface LinkItem {
    path: string
    name: string
    icon: JSX.Element
}

export function Sidebar({ open, setOpen }: Props) {
    const { getSidebarCollapsed, setSidebarCollapsed } = LocalStorage
    const lg = useMediaQuery((theme: Theme) => theme.breakpoints.up('lg'))
    const { t } = useTranslation()

    const links: LinkItem[] = useMemo(
        () => [
            { name: t('sidebar.to-do-list'), icon: <FontAwesomeIcon icon={faListUl} />, path: TO_DO_LIST_ROUTE },
            { name: t('sidebar.user-profile'), icon: <FontAwesomeIcon icon={faGear} />, path: USER_PROFILE_ROUTE }
        ]
        , [t])

    const handleToggle = () => {
        setOpen(prev => {
            setSidebarCollapsed(!prev)
            return !prev
        })
    }

    useEffect(() => {
        if (!lg) {
            setOpen(false)
        } else {
            setOpen(!getSidebarCollapsed())
        }
    }, [lg])

    return (
        <Drawer id='sidebar' sx={styles.root(open)} variant='permanent' open={open}>
            <SidebarToggle open={open} handleToggle={handleToggle} />

            <Box sx={{ height: '100%', zIndex: 1000 }}>
                <Box sx={styles.linksContainer}>
                    <Box>
                        {links.map(props => (
                            <SidebarLink key={props.path} open={open} {...props} />
                        ))}
                    </Box>
                </Box>
            </Box>

            <SignOutButton open={open} name={t('user.actions.sign-out')} icon={<FontAwesomeIcon icon={faArrowRightFromBracket} />} />
        </Drawer>
    )
}

function SidebarLink({
    icon,
    name,
    path,
    open,
}: LinkItem & {
    open: boolean
}) {
    const navigate = useNavigate()
    const { pathname } = useLocation()
    const isSelected = pathname.split('/')?.[1] === path

    const handleLinkClick = () => {
        navigate(path)
    }

    return (
        <Tooltip title={open ? '' : name} placement='right'>
            <Box sx={styles.link(isSelected, open)} onClick={handleLinkClick}>
                <Stack alignItems='center' direction='row' gap='12px'>
                    {icon}
                    <p className='link'>{name}</p>
                </Stack>
            </Box>
        </Tooltip>
    )
}

function SignOutButton({
    icon,
    name,
    open,
}: Omit<LinkItem, 'path'> & {
    open: boolean
}) {
    const { logout } = useAuth()

    const handleSignOut = () => {
        logout()
    }

    return (
        <Tooltip title={open ? '' : name} placement='right'>
            <Box sx={{ ...styles.link(false, open), zIndex: 1000 }}
                onClick={handleSignOut}>
                <Stack alignItems='center' direction='row' gap='12px' >
                    {icon}
                    <p className='link'>{name}</p>
                </Stack>
            </Box>
        </Tooltip>
    )
}


export function SidebarToggle({ open, handleToggle, ...props }: IconButtonProps & { open: boolean; handleToggle: () => void }) {
    const { t } = useTranslation()
    return (
        <Box sx={styles.toggle}>
            <Box sx={styles.toggleContainer}>
                <Button sx={{ display: 'none' }} onClick={handleToggle} />
                <Tooltip title={t('sidebar.tooltip')} placement='right'>
                    <IconButton {...props} className='toggle' sx={styles.toggleIcon} onClick={handleToggle}>
                        <FontAwesomeIcon icon={faBars} />
                    </IconButton>
                </Tooltip>
            </Box>
        </Box>
    )
}