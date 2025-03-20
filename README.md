# Instalador de Wine para Ubuntu

Este script instala **Wine TKG wow64** en Ubuntu de manera sencilla y sin modificar los archivos del sistema. Permite configurar un entorno **Wine de 64 bits** compatible con algunos juegos **x86 de 32 bits**, incluyendo **Wayland** por defecto y **WINEFSYNC**.

## ⭐ Características
- Instala Wine en `~/.local/wine` para evitar conflictos con el sistema.
- Soporta la versión **estable** (Wine 10.0 TKG wow64) o la **última versión** desde Wine-Builds.
- Configura automáticamente:
  - Enlaces binarios
  - Winetricks
  - DXVK
  - Wayland
  - Wine Mono
- Activa **WINEFSYNC** por defecto.
- Crea un **lanzador en el escritorio** y un atajo para cerrar Wine (`Ctrl+Alt+Q`).
- Verifica requisitos como conexión a Internet, arquitectura (**x86_64**) y sistema Ubuntu.

---

## 📋 Requisitos
- **Ubuntu** (probado en arquitecturas `x86_64`).
- Dependencias necesarias:
  ```bash
  sudo apt update && sudo apt install zenity wget tar curl lsb-release
  ```

---

## 🚀 Instalación
1. **Descarga el script y dale permisos de ejecución:**
   ```bash
   chmod +x install_wine.sh
   ```
2. **Ejecuta el script:**
   ```bash
   ./install_wine.sh
   ```
3. **Sigue las instrucciones en pantalla:**
   - Elige entre **"Última"** o **"Estable"**.
   - Observa la barra de progreso mientras se instala.

---

## ❗ Notas
- Si Wine ya está instalado en `/usr/bin/wine`, el script te pedirá desinstalarlo primero.
- Si hay una instalación previa en `~/.local/bin/wine`, puedes optar por desinstalarla.
- **Reinicia tu terminal** después de la instalación para que los cambios en el `PATH` surtan efecto.
- **Requiere conexión a Internet** para descargar los archivos.

---

## 🗑️ Desinstalación
Si elegiste desinstalar durante la ejecución, el script elimina todo automáticamente. De lo contrario, puedes borrarlo manualmente con:
```bash
rm -rf ~/.local/bin/wine* ~/.local/share/wine ~/.wine ~/.cache/wine ~/.config/wine
```

---

## ⚠️ Limitaciones
- **Solo soporta Bash** (Zsh no está implementado aún).
- **Diseñado específicamente para Ubuntu** en arquitecturas `x86_64`.

---

## 📜 Licencia
Este script es de uso libre. Si lo modificas o distribuyes, **considera dar crédito al autor original**.


