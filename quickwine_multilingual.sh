#!/bin/bash

export VERSION

# Detectar el idioma del sistema
detectar_idioma() {
    case "$LANG" in
        es*) idioma="es" ;;
        fr*) idioma="fr" ;;
        de*) idioma="de" ;;
        it*) idioma="it" ;;
        zh*) idioma="zh" ;;
        *) idioma="en" ;; # Inglés por defecto
    esac
    echo "$idioma"
}

# Mensajes traducidos
traducir() {
    local clave="$1"
    local idioma=$(detectar_idioma)

    case "$idioma" in
        "es")
            case "$clave" in
                "error_titulo") echo "Error en la instalación" ;;
                "error_conexion") echo "No se pudo conectar a Internet. Abortando ejecución." ;;
                "bienvenida_titulo") echo "Bienvenido a la instalación de Wine" ;;
                "bienvenida_texto") echo "Vamos a instalar Wine en tu PC Ubuntu sin tocarte los archivos de sistema y de una forma rápida.\n\nWine te permite ejecutar aplicaciones de Windows en Linux.\n\nA continuación, podrás elegir la versión a instalar." ;;
                "selecciona_version") echo "Selecciona la versión de Wine" ;;
                "pregunta_version") echo "¿Qué versión de Wine deseas instalar?" ;;
                "ultima") echo "Última" ;;
                "ultima_desc") echo "La última release disponible en Wine-Builds (puede ser inestable)" ;;
                "estable") echo "Estable" ;;
                "estable_desc") echo "Versión 10.0 (Release_wine10, estable y probada)" ;;
                "instalacion_cancelada") echo "Instalación cancelada por el usuario." ;;
                "instalando_titulo") echo "Instalando Wine" ;;
                "iniciando_texto") echo "Iniciando instalación..." ;;
                "progreso_1") echo "Verificando conexión a Internet y requisitos..." ;;
                "progreso_2") echo "Instalando Wine..." ;;
                "progreso_3") echo "Creando enlaces binarios..." ;;
                "progreso_4") echo "Agregando ~/.local/bin al PATH..." ;;
                "progreso_5") echo "Instalando Winetricks..." ;;
                "progreso_6") echo "Creando lanzador Wine..." ;;
                "progreso_7") echo "Descargando Wine Mono..." ;;
                "progreso_8") echo "Configurando prefix, DXVK, Wayland y atajo..." ;;
                "progreso_9") echo "Instalación completada con éxito!" ;;
                "wine_ya_instalado_sistema") echo "Wine ya está instalado en el sistema (/usr/bin/wine). Desinstálalo antes de usar este script." ;;
                "wine_ya_instalado_local") echo "Se detectó una instalación previa de Wine en ~/.local/bin.\n¿Qué deseas hacer?" ;;
                "opcion_desinstalar") echo "Desinstalar" ;;
                "opcion_desinstalar_desc") echo "Eliminar Wine completamente" ;;
                "opcion_salir") echo "Salir" ;;
                "opcion_salir_desc") echo "Salir sin hacer cambios" ;;
                "accion_cancelada") echo "Acción cancelada." ;;
                "desinstalar_titulo") echo "Desinstalar Wine" ;;
                "desinstalar_texto") echo "Se detectó una instalación previa de Wine en ~/.local/bin.\n¿Deseas eliminarla completamente?" ;;
                "desinstalacion_completa_titulo") echo "Desinstalación completa" ;;
                "desinstalacion_completa_texto") echo "Wine ha sido eliminado completamente." ;;
                "no_ubuntu") echo "No estás en Ubuntu, para el cual estuvo pensado el script." ;;
                "no_arquitectura") echo "No estás en una arquitectura amd64 o x86_64, paramos." ;;
                "url_invalida") echo "No se proporcionó una URL válida." ;;
                "error_descarga_wine") echo "Error al descargar Wine desde la URL." ;;
                "error_descomprimir_wine") echo "Error al descomprimir Wine." ;;
                "error_mover_carpeta") echo "Error al mover la carpeta extraída." ;;
                "error_descarga_winetricks") echo "Error al descargar Winetricks." ;;
                "dxvk_no_instalado") echo "DXVK no está instalado en el prefijo de Wine. Intentá ingresar 'winetricks dxvk' en el terminal por tu cuenta." ;;
                "wayland_no_configurado") echo "Wayland no está configurado como predeterminado en Wine. Intentá ingresar 'winetricks graphics=wayland' en el terminal por tu cuenta." ;;
            esac
            ;;
        "fr")
            case "$clave" in
                "error_titulo") echo "Erreur dans l'installation" ;;
                "error_conexion") echo "Impossible de se connecter à Internet. Abandon de l'exécution." ;;
                "bienvenida_titulo") echo "Bienvenue dans l'installation de Wine" ;;
                "bienvenida_texto") echo "Nous allons installer Wine sur votre PC Ubuntu sans toucher aux fichiers système et de manière rapide.\n\nWine vous permet d'exécuter des applications Windows sur Linux.\n\nEnsuite, vous pourrez choisir la version à installer." ;;
                "selecciona_version") echo "Sélectionnez la version de Wine" ;;
                "pregunta_version") echo "Quelle version de Wine souhaitez-vous installer ?" ;;
                "ultima") echo "Dernière" ;;
                "ultima_desc") echo "La dernière version disponible sur Wine-Builds (peut être instable)" ;;
                "estable") echo "Stable" ;;
                "estable_desc") echo "Version 10.0 (Release_wine10, stable et testée)" ;;
                "instalacion_cancelada") echo "Installation annulée par l'utilisateur." ;;
                "instalando_titulo") echo "Installation de Wine" ;;
                "iniciando_texto") echo "Démarrage de l'installation..." ;;
                "progreso_1") echo "Vérification de la connexion Internet et des prérequis..." ;;
                "progreso_2") echo "Installation de Wine..." ;;
                "progreso_3") echo "Création des liens binaires..." ;;
                "progreso_4") echo "Ajout de ~/.local/bin au PATH..." ;;
                "progreso_5") echo "Installation de Winetricks..." ;;
                "progreso_6") echo "Création du lanceur Wine..." ;;
                "progreso_7") echo "Téléchargement de Wine Mono..." ;;
                "progreso_8") echo "Configuration du préfixe, DXVK, Wayland et raccourci..." ;;
                "progreso_9") echo "Installation terminée avec succès !" ;;
                "wine_ya_instalado_sistema") echo "Wine est déjà installé sur le système (/usr/bin/wine). Désinstallez-le avant d'utiliser ce script." ;;
                "wine_ya_instalado_local") echo "Une installation précédente de Wine a été détectée dans ~/.local/bin.\nQue voulez-vous faire ?" ;;
                "opcion_desinstalar") echo "Désinstaller" ;;
                "opcion_desinstalar_desc") echo "Supprimer Wine complètement" ;;
                "opcion_salir") echo "Quitter" ;;
                "opcion_salir_desc") echo "Quitter sans effectuer de modifications" ;;
                "accion_cancelada") echo "Action annulée." ;;
                "desinstalar_titulo") echo "Désinstaller Wine" ;;
                "desinstalar_texto") echo "Une installation précédente de Wine a été détectée dans ~/.local/bin.\nVoulez-vous la supprimer complètement ?" ;;
                "desinstalacion_completa_titulo") echo "Désinstallation terminée" ;;
                "desinstalacion_completa_texto") echo "Wine a été complètement supprimé." ;;
                "no_ubuntu") echo "Vous n'êtes pas sur Ubuntu, pour lequel ce script a été conçu." ;;
                "no_arquitectura") echo "Vous n'êtes pas sur une architecture amd64 ou x86_64, nous arrêtons." ;;
                "url_invalida") echo "Aucune URL valide n'a été fournie." ;;
                "error_descarga_wine") echo "Erreur lors du téléchargement de Wine depuis l'URL." ;;
                "error_descomprimir_wine") echo "Erreur lors de la décompression de Wine." ;;
                "error_mover_carpeta") echo "Erreur lors du déplacement du dossier extrait." ;;
                "error_descarga_winetricks") echo "Erreur lors du téléchargement de Winetricks." ;;
                "dxvk_no_instalado") echo "DXVK n'est pas installé dans le préfixe de Wine. Essayez d'entrer 'winetricks dxvk' dans le terminal vous-même." ;;
                "wayland_no_configurado") echo "Wayland n'est pas configuré par défaut dans Wine. Essayez d'entrer 'winetricks graphics=wayland' dans le terminal vous-même." ;;
            esac
            ;;
        "de")
            case "$clave" in
                "error_titulo") echo "Fehler bei der Installation" ;;
                "error_conexion") echo "Keine Internetverbindung möglich. Ausführung wird abgebrochen." ;;
                "bienvenida_titulo") echo "Willkommen zur Wine-Installation" ;;
                "bienvenida_texto") echo "Wir werden Wine auf Ihrem Ubuntu-PC installieren, ohne Systemdateien zu verändern und auf schnelle Weise.\n\nWine ermöglicht es Ihnen, Windows-Anwendungen auf Linux auszuführen.\n\nAls Nächstes können Sie die zu installierende Version auswählen." ;;
                "selecciona_version") echo "Wählen Sie die Wine-Version" ;;
                "pregunta_version") echo "Welche Version von Wine möchten Sie installieren?" ;;
                "ultima") echo "Neueste" ;;
                "ultima_desc") echo "Die neueste Version von Wine-Builds (kann instabil sein)" ;;
                "estable") echo "Stabil" ;;
                "estable_desc") echo "Version 10.0 (Release_wine10, stabil und getestet)" ;;
                "instalacion_cancelada") echo "Installation vom Benutzer abgebrochen." ;;
                "instalando_titulo") echo "Wine wird installiert" ;;
                "iniciando_texto") echo "Installation wird gestartet..." ;;
                "progreso_1") echo "Überprüfung der Internetverbindung und Voraussetzungen..." ;;
                "progreso_2") echo "Wine wird installiert..." ;;
                "progreso_3") echo "Binäre Links werden erstellt..." ;;
                "progreso_4") echo "~/.local/bin wird zum PATH hinzugefügt..." ;;
                "progreso_5") echo "Winetricks wird installiert..." ;;
                "progreso_6") echo "Wine-Starter wird erstellt..." ;;
                "progreso_7") echo "Wine Mono wird heruntergeladen..." ;;
                "progreso_8") echo "Präfix, DXVK, Wayland und Verknüpfung werden konfiguriert..." ;;
                "progreso_9") echo "Installation erfolgreich abgeschlossen!" ;;
                "wine_ya_instalado_sistema") echo "Wine ist bereits auf dem System installiert (/usr/bin/wine). Deinstallieren Sie es, bevor Sie dieses Skript verwenden." ;;
                "wine_ya_instalado_local") echo "Eine vorherige Installation von Wine wurde in ~/.local/bin erkannt.\nWas möchten Sie tun?" ;;
                "opcion_desinstalar") echo "Deinstallieren" ;;
                "opcion_desinstalar_desc") echo "Wine vollständig entfernen" ;;
                "opcion_salir") echo "Beenden" ;;
                "opcion_salir_desc") echo "Beenden ohne Änderungen vorzunehmen" ;;
                "accion_cancelada") echo "Aktion abgebrochen." ;;
                "desinstalar_titulo") echo "Wine deinstallieren" ;;
                "desinstalar_texto") echo "Eine vorherige Installation von Wine wurde in ~/.local/bin erkannt.\nMöchten Sie sie vollständig entfernen?" ;;
                "desinstalacion_completa_titulo") echo "Deinstallation abgeschlossen" ;;
                "desinstalacion_completa_texto") echo "Wine wurde vollständig entfernt." ;;
                "no_ubuntu") echo "Sie befinden sich nicht auf Ubuntu, für das dieses Skript gedacht ist." ;;
                "no_arquitectura") echo "Sie befinden sich nicht auf einer amd64- oder x86_64-Architektur, wir stoppen." ;;
                "url_invalida") echo "Es wurde keine gültige URL bereitgestellt." ;;
                "error_descarga_wine") echo "Fehler beim Herunterladen von Wine von der URL." ;;
                "error_descomprimir_wine") echo "Fehler beim Entpacken von Wine." ;;
                "error_mover_carpeta") echo "Fehler beim Verschieben des extrahierten Ordners." ;;
                "error_descarga_winetricks") echo "Fehler beim Herunterladen von Winetricks." ;;
                "dxvk_no_instalado") echo "DXVK ist nicht im Wine-Präfix installiert. Versuchen Sie, 'winetricks dxvk' selbst im Terminal einzugeben." ;;
                "wayland_no_configurado") echo "Wayland ist nicht als Standard in Wine konfiguriert. Versuchen Sie, 'winetricks graphics=wayland' selbst im Terminal einzugeben." ;;
            esac
            ;;
        "it")
            case "$clave" in
                "error_titulo") echo "Errore nell'installazione" ;;
                "error_conexion") echo "Impossibile connettersi a Internet. Esecuzione interrotta." ;;
                "bienvenida_titulo") echo "Benvenuto nell'installazione di Wine" ;;
                "bienvenida_texto") echo "Installeremo Wine sul tuo PC Ubuntu senza toccare i file di sistema e in modo rapido.\n\nWine ti permette di eseguire applicazioni Windows su Linux.\n\nA seguire, potrai scegliere la versione da installare." ;;
                "selecciona_version") echo "Seleziona la versione di Wine" ;;
                "pregunta_version") echo "Quale versione di Wine desideri installare?" ;;
                "ultima") echo "Ultima" ;;
                "ultima_desc") echo "L'ultima versione disponibile su Wine-Builds (potrebbe essere instabile)" ;;
                "estable") echo "Stabile" ;;
                "estable_desc") echo "Versione 10.0 (Release_wine10, stabile e testata)" ;;
                "instalacion_cancelada") echo "Installazione annullata dall'utente." ;;
                "instalando_titulo") echo "Installazione di Wine" ;;
                "iniciando_texto") echo "Avvio dell'installazione..." ;;
                "progreso_1") echo "Verifica della connessione Internet e dei requisiti..." ;;
                "progreso_2") echo "Installazione di Wine..." ;;
                "progreso_3") echo "Creazione dei collegamenti binari..." ;;
                "progreso_4") echo "Aggiunta di ~/.local/bin al PATH..." ;;
                "progreso_5") echo "Installazione di Winetricks..." ;;
                "progreso_6") echo "Creazione del lanciatore Wine..." ;;
                "progreso_7") echo "Download di Wine Mono..." ;;
                "progreso_8") echo "Configurazione del prefisso, DXVK, Wayland e scorciatoia..." ;;
                "progreso_9") echo "Installazione completata con successo!" ;;
                "wine_ya_instalado_sistema") echo "Wine è già installato sul sistema (/usr/bin/wine). Disinstallalo prima di usare questo script." ;;
                "wine_ya_instalado_local") echo "È stata rilevata un'installazione precedente di Wine in ~/.local/bin.\nCosa desideri fare?" ;;
                "opcion_desinstalar") echo "Disinstalla" ;;
                "opcion_desinstalar_desc") echo "Rimuovere Wine completamente" ;;
                "opcion_salir") echo "Esci" ;;
                "opcion_salir_desc") echo "Uscire senza apportare modifiche" ;;
                "accion_cancelada") echo "Azione annullata." ;;
                "desinstalar_titulo") echo "Disinstallare Wine" ;;
                "desinstalar_texto") echo "È stata rilevata un'installazione precedente di Wine in ~/.local/bin.\nDesideri rimuoverla completamente?" ;;
                "desinstalacion_completa_titulo") echo "Disinstallazione completata" ;;
                "desinstalacion_completa_texto") echo "Wine è stato completamente rimosso." ;;
                "no_ubuntu") echo "Non sei su Ubuntu, per il quale è stato pensato questo script." ;;
                "no_arquitectura") echo "Non sei su un'architettura amd64 o x86_64, ci fermiamo." ;;
                "url_invalida") echo "Non è stata fornita un'URL valida." ;;
                "error_descarga_wine") echo "Errore durante il download di Wine dall'URL." ;;
                "error_descomprimir_wine") echo "Errore durante la decompressione di Wine." ;;
                "error_mover_carpeta") echo "Errore durante lo spostamento della cartella estratta." ;;
                "error_descarga_winetricks") echo "Errore durante il download di Winetricks." ;;
                "dxvk_no_instalado") echo "DXVK non è installato nel prefisso di Wine. Prova a inserire 'winetricks dxvk' nel terminale da solo." ;;
                "wayland_no_configurado") echo "Wayland non è configurato come predefinito in Wine. Prova a inserire 'winetricks graphics=wayland' nel terminale da solo." ;;
            esac
            ;;
        "zh")
            case "$clave" in
                "error_titulo") echo "安装错误" ;;
                "error_conexion") echo "无法连接到互联网。中止执行。" ;;
                "bienvenida_titulo") echo "欢迎使用Wine安装程序" ;;
                "bienvenida_texto") echo "我们将在您的Ubuntu PC上安装Wine，不会触及系统文件，安装过程快捷。\n\nWine允许您在Linux上运行Windows应用程序。\n\n接下来，您可以选择要安装的版本。" ;;
                "selecciona_version") echo "选择Wine版本" ;;
                "pregunta_version") echo "您想安装哪个版本的Wine？" ;;
                "ultima") echo "最新" ;;
                "ultima_desc") echo "Wine-Builds中可用的最新版本（可能不稳定）" ;;
                "estable") echo "稳定" ;;
                "estable_desc") echo "版本10.0（Release_wine10，稳定且经过测试）" ;;
                "instalacion_cancelada") echo "用户取消了安装。" ;;
                "instalando_titulo") echo "正在安装Wine" ;;
                "iniciando_texto") echo "开始安装..." ;;
                "progreso_1") echo "正在验证互联网连接和要求..." ;;
                "progreso_2") echo "正在安装Wine..." ;;
                "progreso_3") echo "正在创建二进制链接..." ;;
                "progreso_4") echo "将~/.local/bin添加到PATH..." ;;
                "progreso_5") echo "正在安装Winetricks..." ;;
                "progreso_6") echo "正在创建Wine启动器..." ;;
                "progreso_7") echo "正在下载Wine Mono..." ;;
                "progreso_8") echo "正在配置前缀、DXVK、Wayland和快捷方式..." ;;
                "progreso_9") echo "安装成功完成！" ;;
                "wine_ya_instalado_sistema") echo "Wine已安装在系统上（/usr/bin/wine）。请先卸载它再使用此脚本。" ;;
                "wine_ya_instalado_local") echo "在~/.local/bin中检测到之前的Wine安装。\n您想做什么？" ;;
                "opcion_desinstalar") echo "卸载" ;;
                "opcion_desinstalar_desc") echo "完全删除Wine" ;;
                "opcion_salir") echo "退出" ;;
                "opcion_salir_desc") echo "退出而不进行更改" ;;
                "accion_cancelada") echo "操作已取消。" ;;
                "desinstalar_titulo") echo "卸载Wine" ;;
                "desinstalar_texto") echo "在~/.local/bin中检测到之前的Wine安装。\n您想完全删除它吗？" ;;
                "desinstalacion_completa_titulo") echo "卸载完成" ;;
                "desinstalacion_completa_texto") echo "Wine已完全删除。" ;;
                "no_ubuntu") echo "您不在Ubuntu上，此脚本是为Ubuntu设计的。" ;;
                "no_arquitectura") echo "您不在amd64或x86_64架构上，我们停止。" ;;
                "url_invalida") echo "未提供有效的URL。" ;;
                "error_descarga_wine") echo "从URL下载Wine时出错。" ;;
                "error_descomprimir_wine") echo "解压Wine时出错。" ;;
                "error_mover_carpeta") echo "移动提取的文件夹时出错。" ;;
                "error_descarga_winetricks") echo "下载Winetricks时出错。" ;;
                "dxvk_no_instalado") echo "DXVK未安装在Wine前缀中。请尝试在终端中自行输入'winetricks dxvk'。" ;;
                "wayland_no_configurado") echo "Wayland未配置为Wine的默认值。请尝试在终端中自行输入'winetricks graphics=wayland'。" ;;
            esac
            ;;
        "en")
            case "$clave" in
                "error_titulo") echo "Installation Error" ;;
                "error_conexion") echo "Could not connect to the Internet. Aborting execution." ;;
                "bienvenida_titulo") echo "Welcome to Wine Installation" ;;
                "bienvenida_texto") echo "We will install Wine on your Ubuntu PC without touching system files and in a quick way.\n\nWine allows you to run Windows applications on Linux.\n\nNext, you can choose the version to install." ;;
                "selecciona_version") echo "Select Wine Version" ;;
                "pregunta_version") echo "Which version of Wine would you like to install?" ;;
                "ultima") echo "Latest" ;;
                "ultima_desc") echo "The latest release available on Wine-Builds (may be unstable)" ;;
                "estable") echo "Stable" ;;
                "estable_desc") echo "Version 10.0 (Release_wine10, stable and tested)" ;;
                "instalacion_cancelada") echo "Installation canceled by the user." ;;
                "instalando_titulo") echo "Installing Wine" ;;
                "iniciando_texto") echo "Starting installation..." ;;
                "progreso_1") echo "Checking Internet connection and requirements..." ;;
                "progreso_2") echo "Installing Wine..." ;;
                "progreso_3") echo "Creating binary links..." ;;
                "progreso_4") echo "Adding ~/.local/bin to PATH..." ;;
                "progreso_5") echo "Installing Winetricks..." ;;
                "progreso_6") echo "Creating Wine launcher..." ;;
                "progreso_7") echo "Downloading Wine Mono..." ;;
                "progreso_8") echo "Configuring prefix, DXVK, Wayland, and shortcut..." ;;
                "progreso_9") echo "Installation completed successfully!" ;;
                "wine_ya_instalado_sistema") echo "Wine is already installed on the system (/usr/bin/wine). Uninstall it before using this script." ;;
                "wine_ya_instalado_local") echo "A previous Wine installation was detected in ~/.local/bin.\nWhat would you like to do?" ;;
                "opcion_desinstalar") echo "Uninstall" ;;
                "opcion_desinstalar_desc") echo "Remove Wine completely" ;;
                "opcion_salir") echo "Exit" ;;
                "opcion_salir_desc") echo "Exit without making changes" ;;
                "accion_cancelada") echo "Action canceled." ;;
                "desinstalar_titulo") echo "Uninstall Wine" ;;
                "desinstalar_texto") echo "A previous Wine installation was detected in ~/.local/bin.\nDo you want to remove it completely?" ;;
                "desinstalacion_completa_titulo") echo "Uninstallation Completed" ;;
                "desinstalacion_completa_texto") echo "Wine has been completely removed." ;;
                "no_ubuntu") echo "You are not on Ubuntu, for which this script was designed." ;;
                "no_arquitectura") echo "You are not on an amd64 or x86_64 architecture, we stop." ;;
                "url_invalida") echo "No valid URL was provided." ;;
                "error_descarga_wine") echo "Error downloading Wine from the URL." ;;
                "error_descomprimir_wine") echo "Error decompressing Wine." ;;
                "error_mover_carpeta") echo "Error moving the extracted folder." ;;
                "error_descarga_winetricks") echo "Error downloading Winetricks." ;;
                "dxvk_no_instalado") echo "DXVK is not installed in the Wine prefix. Try entering 'winetricks dxvk' in the terminal yourself." ;;
                "wayland_no_configurado") echo "Wayland is not configured as default in Wine. Try entering 'winetricks graphics=wayland' in the terminal yourself." ;;
            esac
            ;;
    esac
}

mostrar_error() {
    local mensaje="$1"
    zenity --error \
        --title="$(traducir "error_titulo")" \
        --text="$mensaje" \
        --width=400
    exit 1
}

mostrar_bienvenida() {
    check_wine_installed 

    zenity --info \
        --title="$(traducir "bienvenida_titulo")" \
        --text="$(traducir "bienvenida_texto")" \
        --width=400 \
        --height=200

    VERSION=$(zenity --list \
        --title="$(traducir "selecciona_version")" \
        --text="$(traducir "pregunta_version")" \
        --radiolist \
        --column="Seleccionar" --column="Versión" --column="Descripción" \
        FALSE "$(traducir "ultima")" "$(traducir "ultima_desc")" \
        TRUE "$(traducir "estable")" "$(traducir "estable_desc")" \
        --width=500 \
        --height=300)

    if [[ $? -ne 0 ]]; then
        zenity --error --text="$(traducir "instalacion_cancelada")" --width=300
        exit 1
    fi

    if [[ "$VERSION" == "$(traducir "ultima")" ]]; then
        ultima_release_wine
    else
        release_wine10
    fi
}

mostrar_progreso() {
    (
        echo "10" ; echo "# $(traducir "progreso_1")"
        check_internet_connection
        check_wine_installed
        check_ubuntu
        check_architecture

        echo "20" ; echo "# $(traducir "progreso_2")"
        instalar_wine

        echo "40" ; echo "# $(traducir "progreso_3")"
        crear_enlaces_binarios

        echo "50" ; echo "# $(traducir "progreso_4")"
        agregar_local_bin

        echo "60" ; echo "# $(traducir "progreso_5")"
        instalar_winetricks

        echo "70" ; echo "# $(traducir "progreso_6")"
        crear_lanzador_wine

        echo "80" ; echo "# $(traducir "progreso_7")"
        download_mono

        echo "90" ; echo "# $(traducir "progreso_8")"
        setup_prefix
        setup_dxvk
        setup_wayland
        check_wine_settings
        setup_wine_killer_shortcut

        echo "100" ; echo "# $(traducir "progreso_9")"
        sleep 1
    ) | zenity --progress \
        --title="$(traducir "instalando_titulo")" \
        --text="$(traducir "iniciando_texto")" \
        --percentage=0 \
        --auto-close \
        --width=400
}

check_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "zsh"
    elif [[ "$SHELL" == *"bash"* ]]; then
        echo "bash"
    else
        echo "other"
    fi
}

check_internet_connection() {
    ping -c 1 google.com &>/dev/null
    if [ $? -ne 0 ]; then
        mostrar_error "$(traducir "error_conexion")"
    else
        echo "Internet connection established."
    fi
}

check_wine_installed() {
    if command -v wine &>/dev/null && [[ ! -x "$HOME/.local/bin/wine" ]]; then
        mostrar_error "$(traducir "wine_ya_instalado_sistema")"
    elif [[ -x "$HOME/.local/bin/wine" ]]; then
        OPCION=$(zenity --list \
            --title="$(traducir "bienvenida_titulo")" \
            --text="$(traducir "wine_ya_instalado_local")" \
            --radiolist \
            --column="Seleccionar" --column="Opción" --column="Descripción" \
            TRUE "$(traducir "opcion_desinstalar")" "$(traducir "opcion_desinstalar_desc")" \
            FALSE "$(traducir "opcion_salir")" "$(traducir "opcion_salir_desc")" \
            --width=500 \
            --height=300)

        case "$OPCION" in
            "$(traducir "opcion_desinstalar")")
                desinstalar_wine
                ;;
            "$(traducir "opcion_salir")")
                exit 0
                ;;
            *)
                zenity --error --text="$(traducir "accion_cancelada")" --width=300
                exit 1
                ;;
        esac
    fi
}

desinstalar_wine() {
    zenity --question \
        --title="$(traducir "desinstalar_titulo")" \
        --text="$(traducir "desinstalar_texto")" \
        --width=400 \
        --height=200

    if [[ $? -eq 0 ]]; then
        rm -rf ~/.local/bin/wine* ~/.local/share/wine ~/.wine ~/.cache/wine ~/.config/wine
        zenity --info \
            --title="$(traducir "desinstalacion_completa_titulo")" \
            --text="$(traducir "desinstalacion_completa_texto")" \
            --width=400
        exit 0
    fi
}

check_ubuntu() {
    if [[ "$(lsb_release -is)" != "Ubuntu" ]]; then
        mostrar_error "$(traducir "no_ubuntu")"
    else
        echo "You are on Ubuntu."
    fi
}

check_architecture() {
    if [[ "$(uname -m)" != "x86_64" && "$(uname -m)" != "amd64" ]]; then
        mostrar_error "$(traducir "no_arquitectura")"
    else
        echo "You are on an amd64 or x86_64 architecture."
    fi
}

ultima_release_wine() {
    url_api="https://api.github.com/repos/Kron4ek/Wine-Builds/releases"
    respuesta=$(wget -qO- "$url_api")

    if [[ -z "$respuesta" ]]; then
        echo "Failed to get response from GitHub API."
        return 1
    fi

    url=$(echo "$respuesta" | grep -oE '"browser_download_url": ?"([^"]+wine-[0-9]+\.[0-9]+-staging-tkg-amd64-wow64\.tar\.xz)"' | sed -E 's/"browser_download_url": ?"([^"]+)"/\1/' | sort -V | tail -n 1)

    if [[ -z "$url" ]]; then
        echo "Latest Wine staging TKG amd64 wow64 version not found."
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
        mostrar_error "$(traducir "url_invalida")"
    fi
    destino="$HOME/.local/wine"
    if [[ -d "$destino" ]]; then
        echo "Folder $destino already exists. It will be removed to replace it."
        rm -rf "$destino"
    fi
    wget -O "$HOME/wine.tar.xz" "$url" || mostrar_error "$(traducir "error_descarga_wine")"
    tar -xf "$HOME/wine.tar.xz" -C "$HOME/.local/" || mostrar_error "$(traducir "error_descomprimir_wine")"
    carpeta_extraida=$(find "$HOME/.local" -maxdepth 1 -type d -name "wine*" -print -quit)
    mv "$carpeta_extraida" "$destino" || mostrar_error "$(traducir "error_mover_carpeta")"
    rm "$HOME/wine.tar.xz"
    echo "Wine has been installed in $destino."
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
    echo "Symbolic links created in ~/.local/bin and wine wrapper created."
}

agregar_local_bin() {
    shell_actual=$(check_shell)
    case "$shell_actual" in
        bash)
            archivo_bash="$HOME/.bashrc"
            if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$archivo_bash"; then
                echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$archivo_bash"
                echo "Added ~/.local/bin to PATH in $archivo_bash."
                export PATH="$PATH:$HOME/.local/bin"
                echo "PATH updated in this session. Restart your terminal for it to be permanent."
            else
                echo "~/.local/bin already added to PATH in $archivo_bash."
            fi
            ;;
        zsh)
            archivo_zsh="$HOME/.zshrc"
            if ! grep -q "export PATH=\$PATH:\$HOME/.local/bin" "$archivo_zsh"; then
                echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$archivo_zsh"
                echo "Added ~/.local/bin to PATH in $archivo_zsh."
                export PATH="$PATH:$HOME/.local/bin"
                echo "PATH updated in this session. Restart your terminal for it to be permanent."
            else
                echo "~/.local/bin already added to PATH in $archivo_zsh."
            fi
            ;;
        *)
            echo "Shell not recognized. Could not add path to PATH."
            ;;
    esac
}

instalar_winetricks() {
    wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O "$HOME/.local/bin/winetricks" || mostrar_error "$(traducir "error_descarga_winetricks")"
    sed -i '/^#!/a export W_OPT_UNATTENDED=1' "$HOME/.local/bin/winetricks"
    chmod +x "$HOME/.local/bin/winetricks"
    echo "Winetricks installed in .local/bin with W_OPT_UNATTENDED=1 configured."
}

crear_lanzador_wine() {
    local desktop_file="$HOME/.local/share/applications/wine.desktop"

    if [[ -f "$desktop_file" ]]; then
        echo "wine.desktop file already exists. No changes made."
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

    echo "wine.desktop created and correctly associated with Windows executable files."
}

download_mono() {
    local base_url="https://dl.winehq.org/wine/wine-mono/"
    local cache_dir="$HOME/.cache/wine"
    local file_name
    local file_url
    local file_path

    if [[ "$VERSION" == "$(traducir "estable")" ]]; then
        file_name="wine-mono-9.4.0-x86.msi"
        file_url="${base_url}9.4.0/${file_name}"
    else
        latest_version=$(wget -qO- "$base_url" | grep -oE 'href="[0-9]+\.[0-9]+\.[0-9]+/"' | sed -E 's/href="([0-9]+\.[0-9]+\.[0-9]+)\/"/\1/' | sort -V | tail -n1)
        
        if [[ -z "$latest_version" ]]; then
            echo "Could not retrieve the latest wine-mono version."
            return 1
        fi
        
        file_name="wine-mono-${latest_version}-x86.msi"
        file_url="${base_url}${latest_version}/${file_name}"
    fi

    file_path="${cache_dir}/${file_name}"
    if [[ -f "$file_path" ]]; then
        echo "You already have Wine Mono ($file_name) in $cache_dir."
        return 0
    fi

    echo "Downloading Wine Mono ${file_name#wine-mono-}..."
    mkdir -p "$cache_dir"
    wget -q --show-progress -O "$file_path" "$file_url"

    if [[ $? -eq 0 ]]; then
        echo "Wine Mono downloaded successfully to $file_path."
    else
        echo "Error downloading Wine Mono."
        return 1
    fi
}

setup_prefix() {
    if ! command -v wine &> /dev/null; then
        echo "Error: wine is not installed."
        return 1
    fi

    wineboot --init
}

setup_dxvk() {
    if ! command -v winetricks &> /dev/null; then
        echo "Error: winetricks failed to start for some reason."
        return 1
    fi

    winetricks dxvk2051
}

setup_wayland() {
    if ! command -v winetricks &> /dev/null; then
        echo "Error: winetricks failed to start for some reason."
        return 1
    fi

    winetricks graphics=wayland
}

check_wine_settings() {
    local wine_prefix="$HOME/.wine"

    if WINEPREFIX="$wine_prefix" wine reg query "HKEY_CURRENT_USER\Software\Wine\DllOverrides" 2>/dev/null | grep -qE 'dxgi|d3d11'; then
        echo "DXVK is installed in the Wine prefix."
    else
        mostrar_error "$(traducir "dxvk_no_instalado")"
    fi

    if WINEPREFIX="$wine_prefix" wine reg query "HKEY_CURRENT_USER\Software\Wine\Drivers" 2>/dev/null | grep -qi 'wayland'; then
        echo "Wayland is configured as default in Wine."
    else
        mostrar_error "$(traducir "wayland_no_configurado")"
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
            echo "Shortcut created in GNOME."
            ;;
        xfce)
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>Q" -n -t string -s "wineserver -k"
            echo "Shortcut created in XFCE."
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
            echo "Shortcut created in KDE."
            ;;
        cinnamon)
            gsettings set org.cinnamon.desktop.keybindings custom-list "['custom0']"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ name "Wine Killer"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ command "wineserver -k"
            gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ binding "<Ctrl><Alt>Q"
            echo "Shortcut created in Cinnamon."
            ;;
        *)
            echo "Desktop environment not supported."
            return 1
            ;;
    esac
}

# Main
mostrar_progreso