

//  create a frameless window
const { BrowserWindow } = require('electron')

//  hides the traffic lights
const win2 = new BrowserWindow({ titleBarStyle: 'hidden' })
win2.setWindowButtonVisibility(false)

