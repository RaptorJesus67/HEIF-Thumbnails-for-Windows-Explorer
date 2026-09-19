# HEIC Windows Explorer Thumbnail Provider

A lightweight, fast, and native 64-bit Windows Shell Extension (`IThumbnailProvider`) that generates high-resolution thumbnails for Apple HEIC/HEIF photos directly in Windows Explorer.

---

## ⚡ Quick Start (1-Click Install)

1. **Extract all files** from the downloaded `.zip` archive into a folder.
2. **Right-click `install.bat`** and select **"Run as administrator"**  
   *(or simply double-click it; Windows will automatically ask for Administrator permission).*
3. Open any folder containing `.heic` or `.heif` photos in Windows Explorer and set the view to **"Large icons"** or **"Extra large icons"**.
4. Your thumbnails will appear immediately!

---

## 📁 What's in This Package

| File | Purpose |
| :--- | :--- |
| **`install.bat`** | 1-Click installer. Copies the DLL to `Program Files`, registers the COM extension, and refreshes the Windows thumbnail cache. |
| **`uninstall.bat`** | 1-Click uninstaller. Unregisters the extension, cleanly deletes files, and resets the shell cache. |
| **`HeicThumbnailProvider.dll`** | The compiled 64-bit Windows Shell COM library. |
| **`README.md`** | This setup guide and troubleshooting documentation. |

---

## ⚙️ What `install.bat` Does Automatically

1. **Requests Elevation**: Automatically prompts for Windows UAC Administrator rights if not already elevated.
2. **Safe System Installation**: Copies `HeicThumbnailProvider.dll` into `C:\Program Files\HeicThumbnailProvider\`. This ensures the thumbnail provider continues working even if you clear or delete your `Downloads` folder later.
3. **COM Registration**: Calls `regsvr32.exe /s` to register the `IThumbnailProvider` COM interface for `.heic` and `.heif` file associations under `HKEY_CLASSES_ROOT`.
4. **Instant Cache Flush**: Clears stale Windows Explorer thumbnail databases (`thumbcache_*.db`) and restarts `explorer.exe` so previews appear immediately without needing to restart your computer.

---

## 🗑️ How to Uninstall

If you ever want to remove the extension:

1. Right-click **`uninstall.bat`** and select **"Run as administrator"**.
2. The script will:
   - Unregister the COM server (`regsvr32 /u`).
   - Remove the `C:\Program Files\HeicThumbnailProvider\` directory.
   - Flush the Explorer thumbnail cache.

---

## 🔍 Troubleshooting & FAQ

### Q: Thumbnails still show generic icons after running `install.bat`
1. Open Windows Explorer, click **View** &rarr; **Options** &rarr; **Change folder and search options**.
2. Switch to the **View** tab.
3. Make sure **"Always show icons, never thumbnails"** is **unchecked**.
4. Make sure folder view is set to **Medium icons**, **Large icons**, or **Extra large icons**.

### Q: Windows Defender or SmartScreen warning
Because this is an independent open-source project compiled directly from C++ without an expensive commercial code-signing certificate, Windows SmartScreen may show a warning:
- Click **"More info"** &rarr; **"Run anyway"**.
- All source code and build steps are completely transparent, reproducible, and open-source on GitHub.

### Q: Does this require the paid HEVC Video Extension from Microsoft Store?
**No.** This extension uses an embedded, open-source `libheif` + `libde265` decoding pipeline. It functions 100% independently without requiring any Microsoft Store purchases or third-party codec packs.

---

## 💻 System Requirements

- **Operating System:** Windows 10 or Windows 11 (64-bit / x64)
- **Architecture:** x64 (AMD64 / Intel 64)
- **Dependencies:** None (all decoding libraries and CRT runtimes are bundled)

---

## 📄 License & Credits

- Powered by [libheif](https://github.com/strukturag/libheif) and [libde265](https://github.com/strukturag/libde265).
- Released under the open-source MIT License.