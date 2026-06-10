pragma Singleton
import QtQuick

QtObject {
    // Bar-specific colors
    property color barBackground:        "#282828"   // bg0_hard
    property color barClockText:         "#ebdbb2"   // fg1
    property color barWorkspaceActive:   "#ebdbb2"   // fg1
    property color barWorkspaceInactive: "#a89984"   // gray4
    property color barWorkspaceBackground: "#504945" // bg2
    property color barClockBackground:     "#ebdbb2" // fg1
    property color barClockForeground:     "#282828" // bg0_hard
    property color barDateBackground:  "#504945" // bg2
    property color barDateForeground:  "#ebdbb2" // fg1
    property color barVolumeBackground: "#1d2021" // bg0_hard - empty track (whole section)
    property color barVolumeFill:       "#fe8019" // bright-orange - current level
    property color barVolumeMuted:      "#928374" // gray - shown when muted

    // Action tray (Arch logo + quick buttons)
    property color barTrayBackground: "#1d2021" // bg0_hard
    property color barTrayLogo:       "#ebdbb2" // fg1 - logo tint
    property color barTrayAccent:     "#fe8019" // bright-orange - logo tint when pinned
    property color trayButtonDefault: "#ebdbb2" // fg1
    property color trayButtonHover:   "#d79921" // neutral-yellow
    property color trayButtonBorder:  "#504945" // bg2
}