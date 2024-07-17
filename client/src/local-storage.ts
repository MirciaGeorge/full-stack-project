export const LocalStorage = {
  setSidebarCollapsed: handleBoolean('sidebarCollapsed'),
  getSidebarCollapsed: () => Boolean(localStorage.getItem('sidebarCollapsed'))
}

function handleBoolean(key: string) {
  return (isCollapsed: boolean) => {

    if (!isCollapsed) {
      localStorage.setItem(key, 'true')
    } else {
      localStorage.removeItem(key)
    }
  }
}
