
/* Replace the CapsLock key in both Vim and PuTTY with ESC. If the CapsLock key
 * is on, then it should be turned off.
 */
classname = ""
keystate = ""

*CapsLock::
	WinGetClass, classname, A
	if (classname = "Vim" || classname = "PuTTY") {
		SetCapsLockState, Off
		send, {ESC}
	} else {
		GetKeyState, keystate, CapsLock, T
		if (keystate = "D") {
			SetCapsLockState, Off
		} else {
			SetCapsLockState, On
		}
	} 
	return
