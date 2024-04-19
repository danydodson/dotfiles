const { BrowserWindow } = require('electron')

const win = new BrowserWindow()

// hides the traffic lights as long as the 
// config for titleBarStyle is not hidden
win.setWindowButtonVisibility(false)

