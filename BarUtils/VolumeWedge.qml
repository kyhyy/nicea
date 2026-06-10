import QtQuick
import Quickshell.Services.Pipewire
import "../Themes" as Theme

// A chevron-shaped volume meter that matches the bar's triangle separators:
// a notch on the left (the previous section points in) and a point on the
// right (points into the next section). The chevron fills left-to-right with
// the current level. Scroll to change volume (+/- 5%), left-click to mute.
Item {
    id: root
    implicitWidth: 80
    implicitHeight: parent ? parent.height : 30

    // Colors of the neighbouring sections, used to paint the slanted ends so
    // the meter blends into the bar like a separator does.
    property color leftColor: "transparent"
    property color rightColor: "transparent"
    // Width of the slanted ends, matches TriangleSeparator's implicitWidth.
    property int slant: 15

    // The default audio output (speakers / headphones)
    readonly property PwNode sink: Pipewire.defaultAudioSink

    // Keeps the sink's audio properties bound so we get live updates
    PwObjectTracker {
        objects: [root.sink]
    }

    readonly property real volume: root.sink?.audio?.volume ?? 0
    readonly property bool muted: root.sink?.audio?.muted ?? false

    function setVolume(v) {
        if (!root.sink?.ready || !root.sink.audio)
            return;
        root.sink.audio.volume = Math.max(0, Math.min(1, v));
    }

    function toggleMute() {
        if (!root.sink?.ready || !root.sink.audio)
            return;
        root.sink.audio.muted = !root.sink.audio.muted;
    }

    onVolumeChanged: meter.requestPaint()
    onMutedChanged: meter.requestPaint()
    onLeftColorChanged: meter.requestPaint()
    onRightColorChanged: meter.requestPaint()

    Canvas {
        id: meter
        anchors.fill: parent
        antialiasing: false

        onPaint: {
            var ctx = getContext("2d");
            var W = width, H = height, s = root.slant;
            ctx.clearRect(0, 0, W, H);

            // The chevron body: notch on the left, point on the right
            function body() {
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(W - s, 0);
                ctx.lineTo(W, H / 2);   // right point
                ctx.lineTo(W - s, H);
                ctx.lineTo(0, H);
                ctx.lineTo(s, H / 2);   // left notch
                ctx.closePath();
            }

            // Left notch filled with the previous section's color
            ctx.fillStyle = root.leftColor;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(s, H / 2);
            ctx.lineTo(0, H);
            ctx.closePath();
            ctx.fill();

            // Right point's surrounding wedges filled with the next section's color
            ctx.fillStyle = root.rightColor;
            ctx.beginPath();
            ctx.moveTo(W - s, 0);
            ctx.lineTo(W, 0);
            ctx.lineTo(W, H / 2);
            ctx.closePath();
            ctx.moveTo(W - s, H);
            ctx.lineTo(W, H);
            ctx.lineTo(W, H / 2);
            ctx.closePath();
            ctx.fill();

            // Empty track
            ctx.fillStyle = Theme.Colors.barVolumeBackground;
            body();
            ctx.fill();

            // Filled level, clipped to the chevron body
            ctx.save();
            body();
            ctx.clip();
            ctx.fillStyle = root.muted ? Theme.Colors.barVolumeMuted : Theme.Colors.barVolumeFill;
            ctx.fillRect(0, 0, W * root.volume, H);
            ctx.restore();
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        onClicked: root.toggleMute()

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0)
                root.setVolume(root.volume + 0.05);
            else if (wheel.angleDelta.y < 0)
                root.setVolume(root.volume - 0.05);
        }
    }
}
