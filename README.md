# Nicea - A Quickshell Rice

A clean, minimal Quickshell configuration for Hyprland: a single top bar with workspace indicators, a focused-window title, a volume meter, a hover-out action tray, and a clock. Its main purpose is to introduce people to ricing their desktop experience.

## What is this?

This is a "rice" (customized desktop shell configuration) built with [Quickshell](https://quickshell.outfoxxed.me/), a Qt-based shell for Wayland compositors. It's designed to be:

- **Simple** - Main branch is a decluttered starting point
- **Functional** - Daily driver ready with practical features
- **Beginner-friendly** - Well-organized, easy to configure code (at least I hope so)

## Features

### Top Bar

A single bar, with sections joined by triangular chevron separators:

- **Action tray** - An Arch logo on the far left. Hover it to slide out quick-action buttons (power off, reboot, app launcher, Steam); click the logo to pin the tray open.
- **Workspace indicators** - Visual dots showing your Hyprland workspaces; click one to switch to it
- **Focused window title** - Shows the title of the active window
- **Volume meter** - A chevron-shaped meter that fills with the current level (native PipeWire). Scroll over it to change volume, left-click to toggle mute.
- **Date & clock** - Current date and 24-hour time

## Requirements

### Essential
- [Quickshell](https://quickshell.outfoxxed.me/) - The shell itself, built with the PipeWire service
- [Hyprland](https://hyprland.org/) - Wayland compositor
- Qt 6 with QML support
- PipeWire + WirePlumber - For the volume meter

### Optional (for action-tray buttons)
- `wofi` - Application launcher (the "search" button)
- `steam` - If you want the Steam launcher button

## Installation

1. **Clone this repository** to your Quickshell config directory:
   ```bash
   git clone https://github.com/kyhyy/nicea ~/.config/quickshell/nicea
   ```

2. **Configure Quickshell** to use this configuration. Create or edit `~/.config/quickshell/shell.qml`:
   ```qml
   import "nicea"
   ```

3. **Make the scripts executable:**
   ```bash
   chmod +x ~/.config/quickshell/nicea/scripts/*.sh
   ```

4. **Customize your settings** in `Themes/Config.qml` (e.g. bar position).

## Customization

### Changing Colors

Edit `Themes/Colors.qml` to modify the color scheme. The current theme uses Gruvbox:

```qml
property color barBackground: "#282828"   // bar background
property color barVolumeFill: "#fe8019"   // volume meter fill (accent)
// ... and more
```

### Action Tray Buttons

Edit the `model` array in `BarUtils/ActionTray.qml` to add or remove buttons. Each button needs:
- An icon (place an SVG in `icons/`)
- A tooltip
- A command (either a direct argument list, or a shell script in `scripts/`)

### Bar Position

Change bar position in `Themes/Config.qml`:
```qml
readonly property bool barTop: true      // Set to false for bottom bar
readonly property bool barBottom: false  // Set to true for bottom bar
```

## File Structure

```
nicea/
├── shell.qml              # Main entry point
├── Bar.qml                # Top bar component
├── BarUtils/              # Bar widgets
│   ├── ActionTray.qml     # Arch logo + hover/pin action tray
│   ├── TriangleSeparator.qml  # Chevron separator between sections
│   └── VolumeWedge.qml    # Volume meter
├── Themes/                # Theming configuration
│   ├── Colors.qml         # Color palette
│   └── Config.qml         # User configuration
├── scripts/               # Shell scripts for tray actions
│   ├── search.sh
│   └── steam.sh
└── icons/                 # SVG icons
```

## Troubleshooting

**Volume meter not working / not updating:**
- Make sure PipeWire and WirePlumber are running
- Verify your Quickshell build includes the PipeWire service

**Tray buttons (search / Steam) not working:**
- Install required tools: `wofi`, `steam`
- Make scripts executable: `chmod +x ~/.config/quickshell/nicea/scripts/*.sh`

**Icons not appearing:**
- Make sure the SVG files exist in the `icons/` directory

## Credits

- Built with [Quickshell](https://quickshell.outfoxxed.me/)
- Designed for [Hyprland](https://hyprland.org/)

## Contributing

This is my current daily driver, so it's actively maintained! Feel free to:
- Open issues for bugs
- Submit PRs for improvements
- Fork and customize for your own setup
