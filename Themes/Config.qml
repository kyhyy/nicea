pragma Singleton
import QtQuick
import Quickshell

QtObject {
    // ============================================================
    // PATHS
    // ============================================================
    readonly property string configPath: Quickshell.env("HOME") + "/.config/quickshell/nicea"
    readonly property string scriptsPath: configPath + "/scripts"
    readonly property string iconsPath: configPath + "/icons"

    // ============================================================
    // SCRIPTS
    // ============================================================
    readonly property string searchScript: scriptsPath + "/search.sh"
    readonly property string steamScript: scriptsPath + "/steam.sh"

    // ============================================================
    // Bar Positioning - You have to change both values to move the bar
    // ============================================================
    readonly property bool barTop: true
    readonly property bool barBottom: false
}