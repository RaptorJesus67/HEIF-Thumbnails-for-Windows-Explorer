# HEIC / HEIF / HEVC Windows Explorer Thumbnail Provider (C++)

A lightweight, native 64-bit Windows Shell Extension dynamic link library (DLL) implementing the **`IThumbnailProvider`** and **`IInitializeWithStream`** COM interfaces to decode and display high-resolution thumbnails for Apple iPhone and Android `.heic`, `.heif`, and `.hevc` photos directly inside **Windows Explorer**.

---

## ⚡ End-User 1-Click Installation (No Compilation Needed)

1. Download the latest **`HeicThumbnailProvider-v1.1.0-Windows-x64.zip`** from [Releases](https://github.com/RaptorJesus67/HEIF-Thumbnails-for-Windows-Explorer/releases).
2. Extract all files into a folder.
3. **Right-click `install.bat`** and select **"Run as administrator"** *(or simply double-click it; Windows will automatically prompt for Administrator rights)*.
4. The script automatically:
   - Copies `HeicThumbnailProvider.dll` safely into `C:\Program Files\HeicThumbnailProvider\`.
   - Registers the COM shell extension with `regsvr32.exe /s`.
   - Associates `.heic`, `.heif`, and `.hevc` file extensions with the provider.
   - Clears stale Windows thumbnail caches (`thumbcache_*.db`) and restarts `explorer.exe`.
5. Open any folder containing photos, set view to **"Large icons"** or **"Extra large icons"**, and enjoy instant thumbnail previews!

To uninstall at any time, right-click **`uninstall.bat`** and select **"Run as administrator"**.

---

## 📁 Repository Structure

| File / Folder | Purpose |
| :--- | :--- |
| **`src/DllMain.cpp`** | In-process COM DLL entry point (`DllRegisterServer`, `DllUnregisterServer`, `DllGetClassObject`, `DllCanUnloadNow`). Registers `.heic`, `.heif`, and `.hevc`. |
| **`src/HeicThumbnailProvider.cpp`** | Implements `IThumbnailProvider::GetThumbnail` & `IInitializeWithStream::Initialize`. |
| **`src/HeicDecoder.cpp`** | Decoder engine: wraps `libheif`, reads EXIF orientation tags, and generates 32-bit ARGB DIBSection bitmaps. |
| **`src/ClassFactory.cpp`** | COM class factory instantiation for `CLSID_HeicThumbnailProvider`. |
| **`src/Guids.h`** | Defines CLSID `{3A78D321-4E65-4C8D-B6E0-B77C0641A0B2}` and shell interface GUIDs. |
| **`CMakeLists.txt`** | CMake build configuration (links Windows libraries, `shlwapi`, `libheif`). |
| **`vcpkg.json`** | Package manifest declaring `libheif` dependency. |
| **`scripts/install.bat`** | 1-Click end-user installer with automatic UAC elevation. |
| **`scripts/uninstall.bat`** | 1-Click end-user uninstaller. |
| **`scripts/package_release.bat`** | Automated builder that packages the release ZIP for GitHub. |
| **`scripts/register.bat`** | Developer script to register DLL directly from the local build folder. |
| **`scripts/unregister.bat`** | Developer script to unregister DLL and clean registry keys. |
| **`scripts/install.reg`** | Standalone registry file for manual registry import if desired. |
| **`installer.iss`** | (Optional) Inno Setup script to generate a standalone `Setup.exe`. |

---

## 🛠️ Building From Source

### Prerequisites
- **Windows 10 (1809+) or Windows 11 (x64)**
- **Visual Studio 2022** with *Desktop development with C++*
- **vcpkg** (Microsoft C++ package manager)

### Build Steps (CMake + vcpkg)
```powershell
# 1. Install dependencies via vcpkg
vcpkg install --triplet x64-windows

# 2. Configure & Build Release DLL
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release