const { BrowserWindow } = require('electron')

const win = new BrowserWindow()

// hides the traffic lights
win.setWindowButtonVisibility(false)
