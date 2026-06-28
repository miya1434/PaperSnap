#Requires AutoHotkey v2.0
#SingleInstance Force

; ==========================================================
; Configuration
; ==========================================================
downloadDir := EnvGet("USERPROFILE") "\Downloads"
scriptPath := downloadDir "\UploadClipboard.ps1"

; ==========================================================
; Tray Menu
; ==========================================================
A_TrayMenu.Delete()
A_TrayMenu.Add("Upload Clipboard", (*) => RunClipboardUpload())
A_TrayMenu.Default := "Upload Clipboard"
A_TrayMenu.Add()
A_TrayMenu.Add("Reload Script", (*) => Reload())
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())

; ==========================================================
; Hotkey (Ctrl + Shift + P)
; ==========================================================
^+p::RunClipboardUpload()

; ==========================================================
; Launch Upload
; ==========================================================
RunClipboardUpload()
{
    global scriptPath

    if !FileExist(scriptPath)
    {
        MsgBox(
            "UploadClipboard.ps1 was not found.`n`n" scriptPath,
            "Paperless Upload",
            "Iconx"
        )
        return
    }

    ; Launch PowerShell directly and hide the window natively via AHK
    Run(
        'powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "' scriptPath '"',
        ,
        "Hide"
    )
}
