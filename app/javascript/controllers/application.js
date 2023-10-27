import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Import and register all TailwindCSS Components or just the ones you need
// Alert, Autosave, ColorPreview, Dropdown, Modal, Tabs, Popover, Toggle, Slideover
import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('popover', Popover)
application.register('tabs', Tabs)
application.register('toggle', Toggle)
// application.register('color-preview', ColorPreview)
// application.register('slideover', Slideover)


export { application }
