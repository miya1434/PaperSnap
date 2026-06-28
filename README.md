# 📋 PaperSnap – Clipboard Uploader for Paperless-ngx

A lightweight tool to upload images directly from your Windows clipboard to Paperless-ngx with dynamic tag auto-completion, automatic tag creation, notes support, and a background AutoHotkey global launcher.

---

# Features

* **🖼 Direct Clipboard Upload**: Uploads images directly from memory without creating temporary files or requiring manual saving.
* **🏷 Dynamic Tag Autocomplete**: Typing in the tags field dynamically displays a drop-down list of existing tags. Use the **Up/Down Arrow keys** to navigate and **Enter/Tab** to autocomplete.
* **🔒 Safe Tag Creation**: Newly created tags are set to disable auto-matching by default, ensuring they are only assigned to files you explicitly tag.
* **📝 Optional Title**: Uploading without a title is supported; it defaults to `"Clipboard Image"`.
* **📒 Notes Support**: Automatically attaches notes to your document via the Paperless Notes API once the processing is complete.
* **⚡ Intelligent Wait Loop**: Monitors Paperless tasks and immediately links notes the moment the document finishes processing.
* **🔔 Native Notifications**: Displays native Windows system notifications upon successful uploads.
* **🚫 Zero Console Flashing**: Launches completely hidden in the background without exposing console windows.

---

# Requirements

* Windows 10 / Windows 11
* Windows PowerShell **5.1** (pre-installed on Windows)
* Paperless-ngx
* [AutoHotkey v2](https://www.autohotkey.com/) (Required for the global shortcut)

---

# Installation & How to Use

1. **Download the Files**: Download or clone [UploadClipboard.ps1](file:///C:/Users/Touka/.gemini/antigravity/scratch/PaperSnap/UploadClipboard.ps1) and [PaperlessClipboard.ahk](file:///C:/Users/Touka/.gemini/antigravity/scratch/PaperSnap/PaperlessClipboard.ahk) to your `%USERPROFILE%\Downloads\` folder (or your directory of choice).
2. **Configure Paperless Credentials**: Open `UploadClipboard.ps1` and edit lines 33 and 34 to insert your Paperless URL and API token:
   ```powershell
   $PaperlessUrl = "https://paperless.example.com"
   $ApiToken     = "your_api_token_here"
   ```
3. **Run the Script**: Double-click `PaperlessClipboard.ahk` to load the hotkey listener.
Optional: Right Click and select "Compile Script(GUI)" to make a .exe file which you can pin to Start Menu/Taskbar. Please be mindful not to delete the original .ahk script you used to compile the script as any changes to the AHK script need to be done in that and then it needs to be recompiled into the .exe for use.
4. **Trigger Upload**: Copy any image to your clipboard and press `Ctrl + Shift + P`. Enter your metadata and hit Upload!

---

# ⚠️ Vibe-Coded Disclaimer

This project was largely **vibe-coded** and iteratively refined for a personal workflow. It is being shared because others may find it useful.

However, this repository is **not intended to become an actively maintained application**. 

### Please do not open Issues requesting:
* New features / UI changes
* Workflow modifications
* Support for additional document types / file formats
* Feature enhancements

These requests will be declined. You are highly encouraged to fork the repository and customize the code to fit your own requirements!

---

# How the Autocomplete & Tag Matching Works

1. **Suggestive Typing**: When you start typing in the tags field, PaperSnap queries your Paperless-ngx instance for matching tags and pops up a list directly below the text box. 
   * **Arrow Keys**: Move up and down the suggestion list.
   * **Enter or Tab**: Auto-completes the selected tag and automatically appends a comma so you can keep typing your next tag.
2. **Disabled Matching for New Tags**: By default, Paperless-ngx sets new tags to "Any" matching algorithm, causing them to auto-match on document content. PaperSnap overrides this behavior by creating new tags with the matching algorithm set to **"None: disable matching"** (`matching_algorithm = 0`), giving you complete control over your metadata.

---

# Customizable Features

You can customize the scripts by editing specific files at the exact lines shown below.

### 1. Script File Location
If you store `UploadClipboard.ps1` in a folder other than `Downloads`.
* **File to Edit**: `PaperlessClipboard.ahk`
* **Line Number**: Line 9
* **Original Code**:
  ```ahk
  scriptPath := downloadDir "\UploadClipboard.ps1"
  ```
* **Example Edit** (to use a folder named `Scripts` on your D: drive):
  ```ahk
  scriptPath := "D:\Scripts\UploadClipboard.ps1"
  ```

### 2. AutoHotkey Keyboard Shortcut Mapping
To change the global keyboard shortcut that triggers the clipboard uploader.
* **File to Edit**: `PaperlessClipboard.ahk`
* **Line Number**: Line 21
* **Original Code**:
  ```ahk
  ^+p::RunClipboardUpload()
  ```
* **Example Edits**:
  * For `Ctrl + Alt + U`: `^!u::RunClipboardUpload()`
  * For `Win + P`: `#p::RunClipboardUpload()`
  * For `F8`: `F8::RunClipboardUpload()`

### 3. Default Upload Title
To change the fallback title when you leave the title input box blank.
* **File to Edit**: `UploadClipboard.ps1`
* **Line Number**: Line 453
* **Original Code**:
  ```powershell
  $Title = "Clipboard Image"
  ```
* **Example Edit** (to change default to "Quick Scan"):
  ```powershell
  $Title = "Quick Scan"
  ```

### 4. Tag Matching Algorithm (For New Tags)
To change the default matching algorithm assigned to new tags created by the script.
* **File to Edit**: `UploadClipboard.ps1`
* **Line Number**: Line 417
* **Original Code**:
  ```powershell
  matching_algorithm = 0
  ```
* **Example Edits**:
  * Set to `1` for **"Any"** matching (matches any keyword in document content).
  * Set to `6` for **"Auto"** matching (uses Paperless-ngx machine learning).

### 5. Processing Monitoring Speed (Wait Loop)
To adjust how often the script polls your Paperless instance to see if a document is done processing.
* **File to Edit**: `UploadClipboard.ps1`
* **Line Numbers**: Line 517 (loop count limit) and Line 519 (sleep timer)
* **Original Code**:
  ```powershell
  for($i = 0; $i -lt 40; $i++)
  ...
  Start-Sleep -Milliseconds 500
  ```
* **Example Edit** (checks every 200 milliseconds, up to 100 times):
  ```powershell
  for($i = 0; $i -lt 100; $i++)
  ...
  Start-Sleep -Milliseconds 200
  ```

---

# License

MIT License. Feel free to use, modify, and redistribute.
