import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../Themes" as Theme

// Arch logo pinned at the far left. Hover it (or any of its buttons) to slide
// out a row of quick-action buttons; click the logo to pin the row open.
Rectangle {
    id: root

    color: Theme.Colors.barTrayBackground
    implicitWidth: contentRow.width
    implicitHeight: parent ? parent.height : 30

    property bool pinned: false
    readonly property bool expanded: hoverHandler.hovered || pinned

    HoverHandler {
        id: hoverHandler
    }

    Row {
        id: contentRow
        height: parent.height

        // Arch logo
        Item {
            id: logo
            width: 34
            height: parent.height

            Image {
                id: logoImg
                anchors.centerIn: parent
                width: 20
                height: 20
                source: Theme.Config.iconsPath + "/arch.svg"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            ColorOverlay {
                anchors.fill: logoImg
                source: logoImg
                color: root.pinned ? Theme.Colors.barTrayAccent : Theme.Colors.barTrayLogo
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.pinned = !root.pinned
            }
        }

        // Expanding button row
        Item {
            id: trayClip
            height: parent.height
            width: root.expanded ? buttonsRow.width + 10 : 0
            clip: true

            Behavior on width {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Row {
                id: buttonsRow
                x: 6
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6
                // Buttons are only interactive while the tray is open
                enabled: root.expanded

                Repeater {
                    model: [{
                        "icon": "power-off.svg",
                        "tip": "Power off",
                        "cmd": ["systemctl", "poweroff"]
                    }, {
                        "icon": "reload.svg",
                        "tip": "Reboot",
                        "cmd": ["systemctl", "reboot"]
                    }, {
                        "icon": "search.svg",
                        "tip": "Search",
                        "cmd": ["bash", "-c", Theme.Config.searchScript + " &disown"]
                    }, {
                        "icon": "gaming.svg",
                        "tip": "Steam",
                        "cmd": ["bash", "-c", Theme.Config.steamScript + " &disown"]
                    }]

                    Rectangle {
                        id: btn
                        width: 24
                        height: 24
                        radius: 4
                        color: bma.containsMouse ? Theme.Colors.trayButtonHover : Theme.Colors.trayButtonDefault
                        border.width: 1
                        border.color: Theme.Colors.trayButtonBorder
                        scale: bma.containsMouse ? 0.95 : 1

                        Image {
                            anchors.centerIn: parent
                            width: 16
                            height: 16
                            source: Theme.Config.iconsPath + "/" + modelData.icon
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        Process {
                            id: proc
                            running: false
                            command: modelData.cmd
                        }

                        MouseArea {
                            id: bma
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: proc.running = true
                        }

                        Behavior on scale {
                            NumberAnimation {
                                duration: 150
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }
                    }
                }
            }
        }
    }
}
