pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

// nicea acts as the freedesktop notification daemon. Incoming notifications
// are surfaced on the bar in place of the focused-window title, then fade
// away after displayDuration. Silent by design: no sound is ever played.
Singleton {
    id: root

    // How long a notification holds the bar before the title returns (ms).
    property int displayDuration: 5000

    // The notification currently shown on the bar, or null when none.
    property Notification current: null

    // True while a notification is taking over the bar's center.
    readonly property bool active: current !== null

    // What the bar prints: "summary — body", falling back gracefully.
    readonly property string text: {
        if (!current)
            return "";
        if (current.summary && current.body)
            return current.summary + " — " + current.body;
        return current.summary || current.body || current.appName;
    }

    NotificationServer {
        id: server
        keepOnReload: false
        bodySupported: true
        actionsSupported: false
        imageSupported: false

        onNotification: (notification) => {
            notification.tracked = true;
            // Replace whatever's showing with the newest arrival.
            if (root.current && root.current !== notification)
                root.current.expire();
            root.current = notification;
            hideTimer.restart();
        }
    }

    // Returns the bar to the window title and expires the notification.
    Timer {
        id: hideTimer
        interval: root.displayDuration
        onTriggered: {
            const n = root.current;
            root.current = null;
            if (n)
                n.expire();
        }
    }
}
