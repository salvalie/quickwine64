#!/bin/sh

check_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "zsh"
    elif [[ "$SHELL" == *"bash"* ]]; then
        echo "bash"
    else
        echo "otra"
    fi
}

check_internet_connection() {
    ping -c 1 google.com &>/dev/null
    if [ $? -ne 0 ]; then
        echo "No se pudo conectar a Internet. Abortando ejecución."
        exit 1
    else
        echo "Conexión a Internet establecida."
    fi
}

check_architecture() {
  if [[ "$(uname -m)" == "x86_64" || "$(uname -m)" == "amd64" ]]; then
    echo "Estás en una arquitectura amd64 o x86_64"
  else
    echo "No estás en una arquitectura amd64 o x86_64, paramos."
    exit 1
  fi
}

check_ubuntu() {
  if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
    echo "Estás en Ubuntu"
  else
    echo "No estás en Ubuntu, para el cual estuvo pensado el script"
    exit 1
  fi
}

check_wine_installed() {
    if command -v wine &>/dev/null; then
        echo "Wine está instalado ya, por este script o por tu cuenta. No proseguimos."
        exit 1
    else
        echo "Wine no está instalado."
    fi
}

ultima_release_wine() {
  # Obtener la última release de Wine-Builds utilizando la API de GitHub
  url_api="https://api.github.com/repos/Kron4ek/Wine-Builds/releases/latest"

  # Descargar la respuesta JSON de la API de GitHub
  respuesta=$(curl -s "$url_api")

  # Verificar si la respuesta es válida
  if [[ -z "$respuesta" ]]; then
    echo "No se pudo obtener la respuesta de la API de GitHub."
    return 1
  fi

  # Extraer la URL de la última versión desde la respuesta JSON usando jq
  url=$(echo "$respuesta" | jq -r '.assets[] | select(.name | test("wine-.*-staging-tkg-amd64-wow64.tar.xz")) | .browser_download_url' | head -n 1)

  # Verificar si se encontró la URL
  if [[ -z "$url" ]]; then
    echo "No se encontró la última versión de Wine staging TKG."
    return 1
  fi

  # Mostrar la URL de la última versión
  echo "$url"
}

release_wine10() {
  echo "https://github.com/Kron4ek/Wine-Builds/releases/download/10.0/wine-10.0-staging-tkg-amd64-wow64.tar.xz"
}

instalar_wine() {
  url=$(release_wine10)
  
  if [[ -z "$url" ]]; then
    echo "No se proporcionó una URL válida."
    return 1
  fi

  destino="$HOME/.local/wine"

  # Verificar si la carpeta ~/.local/wine existe y eliminarla si es necesario
  if [[ -d "$destino" ]]; then
    echo "La carpeta $destino ya existe. Se eliminará para reemplazarla."
    rm -rf "$destino"
  fi

  wget -O "$HOME/wine-latest.tar.xz" "$url"

  tar -xf "$HOME/wine-latest.tar.xz" -C "$HOME/.local/"

  carpeta_extraida=$(find "$HOME/.local" -maxdepth 1 -type d -name "wine*" -print -quit)
  mv "$carpeta_extraida" "$destino"

  rm "$HOME/wine-latest.tar.xz"

  echo "Wine ha sido instalado en $destino."
}


crear_enlaces_binarios() {
  mkdir -p "$HOME/.local/bin"

  # Crear el wrapper para wine en ~/.local/bin/ de forma que podamos agregar variables de entorno.
  cat > "$HOME/.local/bin/wine" <<EOF
#!/bin/bash
export WINEFSYNC=1
export W_OPT_UNATTENDED=1
exec "$HOME/.local/wine/bin/wine" "\$@"
EOF

    chmod +x "$HOME/.local/bin/wine"

      # Crear los enlaces simbólicos para winecfg, wineserver y wineboot
      ln -sf "$HOME/.local/wine/bin/winecfg" "$HOME/.local/bin/winecfg"
      ln -sf "$HOME/.local/wine/bin/wineserver" "$HOME/.local/bin/wineserver"
      ln -sf "$HOME/.local/wine/bin/wineboot" "$HOME/.local/bin/wineboot"

      echo "Enlaces simbólicos creados en ~/.local/bin y wrapper para wine creado."
}

agregar_local_bin() {
    shell_actual=$(check_shell)

    case "$shell_actual" in
        bash)
            archivo_bash="$HOME/.bashrc"
            if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$archivo_bash"; then
                echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$archivo_bash"
                echo "Se ha agregado ~/.local/bin al PATH en $archivo_bash."
                # Reiniciar la sesión de Bash
                source "$archivo_bash"
                exec bash
            else
                echo "Ya está agregado ~/.local/bin al PATH en $archivo_bash."
            fi
            ;;
        zsh)
            archivo_zsh="$HOME/.zshrc"
            if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$archivo_zsh"; then
                echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$archivo_zsh"
                echo "Se ha agregado ~/.local/bin al PATH en $archivo_zsh."
                # Reiniciar la sesión de Zsh
                source "$archivo_zsh"
                exec zsh
            else
                echo "Ya está agregado ~/.local/bin al PATH en $archivo_zsh."
            fi
            ;;
        *)
            echo "No se ha reconocido la shell. No se pudo agregar la ruta al PATH."
            ;;
    esac
}

instalar_winetricks() {
    wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O "$HOME/.local/bin/winetricks"

    chmod +x "$HOME/.local/bin/winetricks"

    echo "Winetricks ha sido instalado en .local/bin."
}

crear_lanzador_wine() {
    local desktop_file="$HOME/.local/share/applications/wine.desktop"

    # Si el archivo ya existe, no hacer nada
    if [[ -f "$desktop_file" ]]; then
        echo "El archivo wine.desktop ya existe. No se realizaron cambios."
        return 0
    fi

    # Crear el archivo wine.desktop
    mkdir -p "$(dirname "$desktop_file")"
    cat > "$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=Wine Windows Program Loader
Exec=wine start /unix %f
MimeType=application/x-ms-dos-executable;application/x-msi;application/x-ms-shortcut;application/x-bat;application/x-mswinurl
Icon=wine
NoDisplay=false
StartupNotify=true
EOF

    # Actualizar la base de datos de MIME
    update-desktop-database "$HOME/.local/share/applications"

    # Asociar Wine como predeterminado para archivos .exe
    xdg-mime default wine.desktop application/x-ms-dos-executable
    xdg-mime default wine.desktop application/x-msi
    xdg-mime default wine.desktop application/x-ms-shortcut
    xdg-mime default wine.desktop application/x-bat
    xdg-mime default wine.desktop application/x-mswinurl

    echo "wine.desktop creado y asociado correctamente a los archivos ejecutables de Windows."
}


get_wine_version() {
    if ! command -v wine &>/dev/null; then
        echo "Wine no está instalado o no está en el PATH."
        return 1
    fi

    local version
    version=$(wine --version 2>/dev/null | grep -oP '(\d+\.\d+)')

    if [[ -z "$version" ]]; then
        echo "No se pudo determinar la versión de Wine."
        return 1
    fi

    echo "$version"
}

download_latest_wine_mono() {
    local base_url="https://dl.winehq.org/wine/wine-mono/"
    local cache_dir="$HOME/.cache/wine"

    # Obtener la última versión listada en la página
    latest_version=$(curl -s "$base_url" | grep -oP '(?<=href=")[0-9]+\.[0-9]+\.[0-9]+(?=/")' | sort -V | tail -n1)

    if [[ -z "$latest_version" ]]; then
        echo "No se pudo obtener la última versión de wine-mono."
        return 1
    fi

    local file_name="wine-mono-${latest_version}-x86.msi"
    local file_url="${base_url}${latest_version}/${file_name}"
    local file_path="${cache_dir}/${file_name}"

    # Si el archivo ya existe, no lo descargamos de nuevo
    if [[ -f "$file_path" ]]; then
        echo "Ya tienes la última versión de Wine Mono ($file_name) en $cache_dir"
        return 0
    fi

    # Descargar el archivo
    echo "Descargando Wine Mono $latest_version..."
    mkdir -p "$cache_dir"
    wget -q --show-progress -O "$file_path" "$file_url"

    if [[ $? -eq 0 ]]; then
        echo "Wine Mono descargado correctamente en $file_path"
    else
        echo "Error al descargar Wine Mono."
        return 1
    fi
}

setup_prefix() {
    if ! command -v wine &> /dev/null; then
        echo "Error: wine no está instalado."
        return 1
    fi

    wineboot --init
}

setup_dxvk() {
    if ! command -v winetricks &> /dev/null; then
        echo "Error: winetricks no arrancó por alguna razón."
        return 1
    fi

    winetricks dxvk
}

setup_wayland() {
    if ! command -v winetricks &> /dev/null; then
        echo "Error: winetricks no arrancó por alguna razón."
        return 1
    fi

    winetricks graphics=wayland
}


detect_desktop_environment() {
    if [[ "$XDG_CURRENT_DESKTOP" =~ GNOME ]]; then
        echo "gnome"
    elif [[ "$XDG_CURRENT_DESKTOP" =~ XFCE ]]; then
        echo "xfce"
    elif [[ "$XDG_CURRENT_DESKTOP" =~ KDE ]]; then
        echo "kde"
    elif [[ "$XDG_CURRENT_DESKTOP" =~ Cinnamon ]]; then
        echo "cinnamon"
    else
        echo "unknown"
    fi
}

setup_wine_killer_shortcut() {
    local de=$(detect_desktop_environment)

    case "$de" in
        gnome)
            gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wine-killer/']"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wine-killer/ name "Wine Killer"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wine-killer/ command "wineserver -k"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wine-killer/ binding "<Ctrl><Alt>Q"
            echo "Atajo creado en GNOME"
            ;;

        xfce)
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>Q" -n -t string -s "wineserver -k"
            echo "Atajo creado en XFCE"
            ;;

        kde)
            mkdir -p "$HOME/.config/khotkeys"
            cat > "$HOME/.config/khotkeys/wine-killer.khotkeys" <<EOF
[Hotkeys]
Comment=Wine Killer
DataCount=1
Data_1_Command=wine_killer
Data_1_GlobalShortcut=Ctrl+Alt+Q
Data_1_Type=SIMPLE_ACTION_DATA
Data_1_Exec=wineserver -k
EOF
            qdbus org.kde.kglobalaccel /component/khotkeys invokeShortcut "Wine Killer"
            echo "Atajo creado en KDE"
            ;;

        cinnamon)
            gsettings set org.cinnamon.desktop.keybindings custom-list "['custom0']"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ name "Wine Killer"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ command "wineserver -k"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ binding "<Ctrl><Alt>Q"
            echo "Atajo creado en Cinnamon"
            ;;

        *)
            echo "Entorno de escritorio no soportado."
            return 1
            ;;
    esac
}

# Llamada a las funciones

check_internet_connection
check_wine_installed
check_ubuntu
check_architecture
instalar_wine
crear_enlaces_binarios
agregar_local_bin
instalar_winetricks
crear_lanzador_wine
download_latest_wine_mono
setup_prefix
setup_dxvk
setup_wayland
setup_wine_killer_shortcut


