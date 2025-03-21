# QuickWine64

A bash script to quickly install Wine on Ubuntu without messing with system files. Below are the instructions, notes, and features in multiple languages.

---

## Español

### QuickWine64
Un script de bash para instalar Wine rápidamente en Ubuntu sin alterar los archivos del sistema.

#### Instrucciones
1. Descarga el script desde este repositorio.
2. Abre tu terminal preferida.
3. Navega hasta donde descargaste el script.
4. Escribe `chmod +x quickwine64.sh` para hacerlo ejecutable.
5. Escribe `./quickwine64.sh` para ejecutarlo.
6. ¡Sigue las indicaciones en pantalla para instalar Wine!

#### Notas
- Este script solo ha sido probado en Ubuntu, específicamente en versiones de 64 bits.
- Requiere `zenity` para las indicaciones de la interfaz gráfica.
- Si Wine ya está instalado en todo el sistema (verifica con `which wine`), desinstálalo antes de ejecutar este script (por ejemplo, `sudo apt remove wine`).
- Puedes desinstalar la versión de Wine de este script eliminando `~/.local/bin/wine*`, `~/.local/share/wine`, `~/.wine`, `~/.cache/wine` y `~/.config/wine`.

#### Características
- Instala la última versión o la versión estable 10.0 de Wine desde [Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds).
- Agrega `~/.local/bin` al PATH si no está presente.
- Instala Winetricks con el modo desatendido activado.
- Crea un lanzador de Wine (wine.desktop) y lo asocia con los tipos MIME de ejecutables de Windows.
- Descarga la versión correspondiente de Wine Mono (la estable obtiene 9.4.0, la última obtiene la más reciente).
- Configura el prefijo de Wine con wineboot.
- Instala DXVK para DirectX basado en Vulkan.
- Configura el controlador gráfico Wayland.
- Crea un atajo CTRL+ALT+Q para terminar los procesos de Wine (funciona en Gnome, XFCE, KDE, Cinnamon).

---

## Français

### QuickWine64
Un script bash pour installer Wine rapidement sur Ubuntu sans modifier les fichiers système.

#### Instructions
1. Téléchargez le script depuis ce dépôt.
2. Ouvre votre terminal préféré.
3. Naviguez jusqu'à l'endroit où vous avez téléchargé le script.
4. Tapez `chmod +x quickwine64.sh` pour le rendre exécutable.
5. Tapez `./quickwine64.sh` pour le lancer.
6. Suivez les instructions à l'écran pour installer Wine !

#### Notes
- Ce script n'a été testé que sur Ubuntu, spécifiquement les versions 64 bits.
- Nécessite `zenity` pour les invites de l'interface graphique.
- Si Wine est déjà installé globalement (vérifiez avec `which wine`), désinstallez-le avant d'exécuter ce script (par exemple, `sudo apt remove wine`).
- Vous pouvez désinstaller la version de Wine de ce script en supprimant `~/.local/bin/wine*`, `~/.local/share/wine`, `~/.wine`, `~/.cache/wine` et `~/.config/wine`.

#### Caractéristiques
- Installe la dernière version ou la version stable 10.0 de Wine depuis [Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds).
- Ajoute `~/.local/bin` au PATH s'il n'est pas présent.
- Installe Winetricks avec le mode sans surveillance activé.
- Crée un lanceur Wine (wine.desktop) et l'associe aux types MIME des exécutables Windows.
- Télécharge la version correspondante de Wine Mono (la stable obtient 9.4.0, la dernière obtient la plus récente).
- Configure le préfixe Wine avec wineboot.
- Installe DXVK pour DirectX basé sur Vulkan.
- Configure le pilote graphique Wayland.
- Crée un raccourci CTRL+ALT+Q pour arrêter les processus Wine (fonctionne sous Gnome, XFCE, KDE, Cinnamon).

---

## Deutsch

### QuickWine64
Ein Bash-Skript, um Wine schnell auf Ubuntu zu installieren, ohne Systemdateien zu verändern.

#### Anweisungen
1. Laden Sie das Skript aus diesem Repository herunter.
2. Öffnen Sie Ihr bevorzugtes Terminal.
3. Navigieren Sie zu dem Ort, an dem Sie das Skript heruntergeladen haben.
4. Geben Sie `chmod +x quickwine64.sh` ein, um es ausführbar zu machen.
5. Geben Sie `./quickwine64.sh` ein, um es auszuführen.
6. Folgen Sie den Anweisungen auf dem Bildschirm, um Wine zu installieren!

#### Hinweise
- Dieses Skript wurde nur auf Ubuntu getestet, insbesondere auf 64-Bit-Versionen.
- Erfordert `zenity` für die grafischen Benutzeroberflächen-Anweisungen.
- Wenn Wine bereits systemweit installiert ist (überprüfen Sie mit `which wine`), deinstallieren Sie es vor dem Ausführen dieses Skripts (z. B. `sudo apt remove wine`).
- Sie können die Wine-Version dieses Skripts deinstallieren, indem Sie `~/.local/bin/wine*`, `~/.local/share/wine`, `~/.wine`, `~/.cache/wine` und `~/.config/wine` löschen.

#### Funktionen
- Installiert die neueste Version oder die stabile Version 10.0 von Wine von [Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds).
- Fügt `~/.local/bin` zum PATH hinzu, falls nicht vorhanden.
- Installiert Winetricks mit aktiviertem unbeaufsichtigtem Modus.
- Erstellt einen Wine-Starter (wine.desktop) und verknüpft ihn mit Windows-ausführbaren Mimetypen.
- Lädt die passende Wine-Mono-Version herunter (stabil erhält 9.4.0, neueste erhält die aktuellste).
- Richtet das Wine-Präfix mit wineboot ein.
- Installiert DXVK für Vulkan-basiertes DirectX.
- Konfiguriert den Wayland-Grafiktreiber.
- Erstellt eine CTRL+ALT+Q-Verknüpfung, um Wine-Prozesse zu beenden (funktioniert in Gnome, XFCE, KDE, Cinnamon).

---

## Italiano

### QuickWine64
Uno script bash per installare Wine rapidamente su Ubuntu senza modificare i file di sistema.

#### Istruzioni
1. Scarica lo script da questo repository.
2. Apri il tuo terminale preferito.
3. Naviga fino alla posizione in cui hai scaricato lo script.
4. Digita `chmod +x quickwine64.sh` per renderlo eseguibile.
5. Digita `./quickwine64.sh` per eseguirlo.
6. Segui le istruzioni sullo schermo per installare Wine!

#### Note
- Questo script è stato testato solo su Ubuntu, in particolare su versioni a 64 bit.
- Richiede `zenity` per le indicazioni dell'interfaccia grafica.
- Se Wine è già installato a livello di sistema (verifica con `which wine`), disinstallalo prima di eseguire questo script (ad esempio, `sudo apt remove wine`).
- Puoi disinstallare la versione di Wine di questo script eliminando `~/.local/bin/wine*`, `~/.local/share/wine`, `~/.wine`, `~/.cache/wine` e `~/.config/wine`.

#### Caratteristiche
- Installa l'ultima versione o la versione stabile 10.0 di Wine da [Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds).
- Aggiunge `~/.local/bin` al PATH se non presente.
- Installa Winetricks con la modalità non assistita abilitata.
- Crea un lanciatore Wine (wine.desktop) e lo associa ai tipi MIME degli eseguibili Windows.
- Scarica la versione corrispondente di Wine Mono (la stabile ottiene 9.4.0, l'ultima ottiene la più recente).
- Configura il prefisso Wine con wineboot.
- Installa DXVK per DirectX basato su Vulkan.
- Configura il driver grafico Wayland.
- Crea una scorciatoia CTRL+ALT+Q per terminare i processi Wine (funziona su Gnome, XFCE, KDE, Cinnamon).

---

## 中文 (Mandarín)

### QuickWine64
一个bash脚本，用于在Ubuntu上快速安装Wine，而不干扰系统文件。

#### 说明
1. 从此存储库下载脚本。
2. 打开您喜欢的终端。
3. 导航到您下载脚本的位置。
4. 输入`chmod +x quickwine64.sh`以使其可执行。
5. 输入`./quickwine64.sh`以运行它。
6. 按照屏幕上的提示安装Wine！

#### 注意
- 此脚本仅在Ubuntu上测试过，特别是64位版本。
- 需要`zenity`来显示图形界面提示。
- 如果Wine已全局安装（用`which wine`检查），请在运行此脚本前卸载它（例如，`sudo apt remove wine`）。
- 您可以通过删除`~/.local/bin/wine*`、`~/.local/share/wine`、`~/.wine`、`~/.cache/wine`和`~/.config/wine`来卸载此脚本的Wine版本。

#### 功能
- 从[Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds)安装最新版本或稳定的10.0版本Wine。
- 如果`~/.local/bin`不在PATH中，则将其添加。
- 安装Winetricks并启用无人值守模式。
- 创建Wine启动器（wine.desktop）并将其与Windows可执行文件的MIME类型关联。
- 下载匹配的Wine Mono版本（稳定版获取9.4.0，最新版获取最新版本）。
- 使用wineboot设置Wine前缀。
- 安装基于Vulkan的DirectX的DXVK。
- 配置Wayland图形驱动程序。
- 创建CTRL+ALT+Q快捷键以终止Wine进程（在Gnome、XFCE、KDE、Cinnamon中有效）。

---

## English

### QuickWine64
A bash script to quickly install Wine on Ubuntu without messing with system files.

#### Instructions
1. Download the script from this repo.
2. Open your terminal of choice.
3. Navigate to wherever you downloaded the script.
4. Type `chmod +x quickwine64.sh` to make it executable.
5. Type `./quickwine64.sh` to run it.
6. Follow the on-screen prompts to install Wine!

#### Notes
- This script has only been tested on Ubuntu, specifically 64-bit versions.
- Requires `zenity` for the GUI prompts.
- If Wine is already installed system-wide (check with `which wine`), uninstall it before running this script (e.g., `sudo apt remove wine`).
- You can uninstall this script's Wine version by deleting `~/.local/bin/wine*`, `~/.local/share/wine`, `~/.wine`, `~/.cache/wine`, and `~/.config/wine`.

#### Features
- Installs latest release or stable 10.0 Wine from [Kron4ek's Wine-Builds](https://github.com/Kron4ek/Wine-Builds).
- Adds `~/.local/bin` to PATH if not present.
- Installs Winetricks with unattended mode enabled.
- Creates a Wine launcher (wine.desktop) and associates it with Windows executable mimetypes.
- Downloads matching Wine Mono version (stable gets 9.4.0, latest gets latest).
- Sets up Wine prefix with wineboot.
- Installs DXVK for Vulkan-based DirectX.
- Configures Wayland graphics driver.
- Creates a CTRL+ALT+Q shortcut to kill Wine processes (works in Gnome, XFCE, KDE, Cinnamon).

---
