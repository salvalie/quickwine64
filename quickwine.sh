#!/bin/bash

export VERSION

mostrar_error() {
    local mensaje="$1"
    zenity --error \
        --title="Error en la instalación" \
        --text="$mensaje" \
        --width=400
    exit 1
}


mostrar_bienvenida() {
    check_wine_installed 

    zenity --info \
        --title="Bienvenido a la instalación de Wine" \
        --text="Vamos a instalar Wine en tu PC Ubuntu sin tocarte los archivos de sistema y de una forma rápida.\n\nWine te permite ejecutar aplicaciones de Windows en Linux.\n\nA continuación, podrás elegir la versión a instalar." \
        --width=400 \
        --height=200

    VERSION=$(zenity --list \
        --title="Selecciona la versión de Wine" \
        --text="¿Qué versión de Wine deseas instalar?" \
        --radiolist \
        --column="Seleccionar" --column="Versión" --column="Descripción" \
        FALSE "Última" "La última release disponible en Wine-Builds (puede ser inestable)" \
        TRUE "Estable" "Versión 10.0 (release_wine10, estable y probada)" \
        --width=500 \
        --height=300)

    if [[ $? -ne 0 ]]; then
        zenity --error --text="Instalación cancelada por el usuario." --width=300
        exit 1
    fi

    if [[ "$VERSION" == "Última" ]]; then
        ultima_release_wine
    else
        release_wine10
    fi
}

mostrar_progreso() {
    (
        echo "10" ; echo "# Verificando conexión a Internet y requisitos..."
        #check_internet_connection
        check_wine_installed
        check_ubuntu
        check_architecture

        echo "20" ; echo "# Instalando Wine..."
        instalar_wine

        echo "40" ; echo "# Creando enlaces binarios..."
        crear_enlaces_binarios

        echo "50" ; echo "# Agregando ~/.local/bin al PATH..."
        agregar_local_bin

        echo "60" ; echo "# Instalando Winetricks..."
        instalar_winetricks

        echo "70" ; echo "# Creando lanzador Wine..."
        crear_lanzador_wine

        echo "80" ; echo "# Descargando Wine Mono..."
        download_mono

        echo "90" ; echo "# Configurando prefix, DXVK, Wayland y atajo..."
        setup_prefix
        setup_dxvk
        setup_wayland
        check_wine_settings
        setup_wine_killer_shortcut

        echo "100" ; echo "# Instalación completada con éxito!"
        sleep 1
    ) | zenity --progress \
        --title="Instalando Wine" \
        --text="Iniciando instalación..." \
        --percentage=0 \
        --auto-close \
        --width=400
}

# Esto por ahora no sirve, usamos solo bash. Después vemos como le damos soporte a ZSH.
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
        mostrar_error "No se pudo conectar a Internet. Abortando ejecución."
    else
        echo "Conexión a Internet establecida."
    fi
}

check_wine_installed() {
    if command -v wine &>/dev/null && [[ ! -x "$HOME/.local/bin/wine" ]]; then
        # Si Wine está instalado en el sistema (pero no en ~/.local/bin), salimos
        mostrar_error "Wine ya está instalado en el sistema (/usr/bin/wine). Desinstálalo antes de usar este script."
    elif [[ -x "$HOME/.local/bin/wine" ]]; then
        # Si está instalado en ~/.local/bin, forzamos al usuario a elegir entre desinstalar o salir.
        OPCION=$(zenity --list \
            --title="Wine ya instalado" \
            --text="Se detectó una instalación previa de Wine en ~/.local/bin.\n¿Qué deseas hacer?" \
            --radiolist \
            --column="Seleccionar" --column="Opción" --column="Descripción" \
            TRUE "Desinstalar" "Eliminar Wine completamente" \
            FALSE "Salir" "Salir sin hacer cambios" \
            --width=500 \
            --height=300)

        case "$OPCION" in
            "Desinstalar")
                desinstalar_wine
                ;;
            "Salir")
                exit 0
                ;;
            *)
                zenity --error --text="Acción cancelada." --width=300
                exit 1
                ;;
        esac
    fi
}

desinstalar_wine() {
    zenity --question \
        --title="Desinstalar Wine" \
        --text="Se detectó una instalación previa de Wine en ~/.local/bin.\n¿Deseas eliminarla completamente?" \
        --width=400 \
        --height=200

    if [[ $? -eq 0 ]]; then
        rm -rf ~/.local/bin/wine* ~/.local/share/wine ~/.wine ~/.cache/wine ~/.config/wine
        zenity --info --title="Desinstalación completa" --text="Wine ha sido eliminado completamente." --width=400
        exit 0
    fi
}

check_ubuntu() {
    if [[ "$(lsb_release -is)" != "Ubuntu" ]]; then
        mostrar_error "No estás en Ubuntu, para el cual estuvo pensado el script."
    else
        echo "Estás en Ubuntu"
    fi
}

check_architecture() {
    if [[ "$(uname -m)" != "x86_64" && "$(uname -m)" != "amd64" ]]; then
        mostrar_error "No estás en una arquitectura amd64 o x86_64, paramos."
    else
        echo "Estás en una arquitectura amd64 o x86_64"
    fi
}

ultima_release_wine() {
  url_api="https://api.github.com/repos/Kron4ek/Wine-Builds/releases"
  respuesta=$(wget -qO- "$url_api")

  if [[ -z "$respuesta" ]]; then
    echo "No se pudo obtener la respuesta de la API de GitHub."
    return 1
  fi

  url=$(echo "$respuesta" | grep -oE '"browser_download_url": ?"([^"]+wine-[0-9]+\.[0-9]+-staging-tkg-amd64-wow64\.tar\.xz)"' | sed -E 's/"browser_download_url": ?"([^"]+)"/\1/' | sort -V | tail -n 1)

  if [[ -z "$url" ]]; then
    echo "No se encontró la última versión de Wine staging TKG amd64 wow64."
    return 1
  fi
  echo "$url"
}

release_wine10() {
    echo "https://github.com/Kron4ek/Wine-Builds/releases/download/10.0/wine-10.0-staging-tkg-amd64-wow64.tar.xz"
}

instalar_wine() {
    url=$(mostrar_bienvenida)
    if [[ -z "$url" ]]; then
        mostrar_error "No se proporcionó una URL válida."
    fi
    destino="$HOME/.local/wine"
    if [[ -d "$destino" ]]; then
        echo "La carpeta $destino ya existe. Se eliminará para reemplazarla."
        rm -rf "$destino"
    fi
    wget -O "$HOME/wine.tar.xz" "$url" || mostrar_error "Error al descargar Wine desde $url"
    tar -xf "$HOME/wine.tar.xz" -C "$HOME/.local/" || mostrar_error "Error al descomprimir Wine"
    carpeta_extraida=$(find "$HOME/.local" -maxdepth 1 -type d -name "wine*" -print -quit)
    mv "$carpeta_extraida" "$destino" || mostrar_error "Error al mover la carpeta extraída"
    rm "$HOME/wine.tar.xz"
    echo "Wine ha sido instalado en $destino."
}

crear_enlaces_binarios() {
    mkdir -p "$HOME/.local/bin"
    cat > "$HOME/.local/bin/wine" <<EOF
#!/bin/bash
export WINEFSYNC=1
exec "$HOME/.local/wine/bin/wine" "\$@"
EOF
    chmod +x "$HOME/.local/bin/wine"
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
                export PATH="$PATH:$HOME/.local/bin"
                echo "PATH actualizado en esta sesión. Reinicia tu terminal para que sea permanente."
            else
                echo "Ya está agregado ~/.local/bin al PATH en $archivo_bash."
            fi
            ;;
        zsh)
            archivo_zsh="$HOME/.zshrc"
            if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$archivo_zsh"; then
                echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$archivo_zsh"
                echo "Se ha agregado ~/.local/bin al PATH en $archivo_zsh."
                export PATH="$PATH:$HOME/.local/bin"
                echo "PATH actualizado en esta sesión. Reinicia tu terminal para que sea permanente."
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
    wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O "$HOME/.local/bin/winetricks" || mostrar_error "Error al descargar winetricks"
    sed -i '/^#!/a export W_OPT_UNATTENDED=1' "$HOME/.local/bin/winetricks"
    chmod +x "$HOME/.local/bin/winetricks"
    echo "Winetricks ha sido instalado en .local/bin con W_OPT_UNATTENDED=1 configurado."
}

crear_lanzador_wine() {
    local desktop_file="$HOME/.local/share/applications/wine.desktop"

    if [[ -f "$desktop_file" ]]; then
        echo "El archivo wine.desktop ya existe. No se realizaron cambios."
        return 0
    fi

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

    update-desktop-database "$HOME/.local/share/applications"

    xdg-mime default wine.desktop application/x-ms-dos-executable
    xdg-mime default wine.desktop application/x-msi
    xdg-mime default wine.desktop application/x-ms-shortcut
    xdg-mime default wine.desktop application/x-bat
    xdg-mime default wine.desktop application/x-mswinurl

    echo "wine.desktop creado y asociado correctamente a los archivos ejecutables de Windows."
}

download_mono() {
    local base_url="https://dl.winehq.org/wine/wine-mono/"
    local cache_dir="$HOME/.cache/wine"
    local file_name
    local file_url
    local file_path

    if [[ "$VERSION" == "Estable" ]]; then
        # Versión fija para Wine 10 estable
        file_name="wine-mono-9.4.0-x86.msi"
        file_url="${base_url}9.4.0/${file_name}"
    else
        # Última versión para Wine latest
        latest_version=$(wget -qO- "$base_url" | grep -oE 'href="[0-9]+\.[0-9]+\.[0-9]+/"' | sed -E 's/href="([0-9]+\.[0-9]+\.[0-9]+)\/"/\1/' | sort -V | tail -n1)
        
        if [[ -z "$latest_version" ]]; then
            echo "No se pudo obtener la última versión de wine-mono."
            return 1
        fi
        
        file_name="wine-mono-${latest_version}-x86.msi"
        file_url="${base_url}${latest_version}/${file_name}"
    fi

    file_path="${cache_dir}/${file_name}"
    if [[ -f "$file_path" ]]; then
        echo "Ya tienes Wine Mono ($file_name) en $cache_dir"
        return 0
    fi

    echo "Descargando Wine Mono ${file_name%wine-mono-}..."
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

check_wine_settings() {
    local wine_prefix="$HOME/.wine"

    # Verificar si DXVK está instalado consultando las claves de registro de Wine
    if WINEPREFIX="$wine_prefix" wine reg query "HKEY_CURRENT_USER\Software\Wine\DllOverrides" 2>/dev/null | grep -qE 'dxgi|d3d11'; then
        echo "DXVK está instalado en el prefijo de Wine."
    else
        mostrar_error "DXVK no está instalado en el prefijo de Wine. Intentá ingresar 'winetricks dxvk' en el terminal por tu cuenta"
    fi

    # Verificar si Wayland está configurado como predeterminado
    if WINEPREFIX="$wine_prefix" wine reg query "HKEY_CURRENT_USER\Software\Wine\Drivers" 2>/dev/null | grep -qi 'wayland'; then
        echo "Wayland está configurado como predeterminado en Wine."
    else
        mostrar_error "Wayland no está configurado como predeterminado en Wine. Inmtentá ingresar 'winetricks graphics=wayland' en el terminal por tu cuenta"
    fi
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

# Main
mostrar_progreso