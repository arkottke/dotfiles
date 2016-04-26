hasValue(haystack, needle) {
    if(!isObject(haystack))
        return false
    if(haystack.Length()==0)
        return false
    for k,v in haystack
        if(v==needle)
            return true
    return false
}

; Persistant numlock
SetNumlockState, AlwaysOn

/* Replace the CapsLock key in both Vim and PuTTY with ESC. If the CapsLock key
 * is on, then it should be turned off.
 */

*CapsLock::
    blacklist := ["Vim", "mintty", "PuTTY", "SunAwtFrame"]
    classname = ""
    WinGetClass, classname, A
    if (hasValue(blacklist, classname)) {
        SetCapsLockState, Off
        send, {ESC}
    } else {
        state := GetKeyState("Capslock", "T")
        if (state) {
            SetCapsLockState, Off
        } else {
            SetCapsLockState, On
        }
    } 
    return
