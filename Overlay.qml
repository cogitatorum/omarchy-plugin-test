import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root

    property var shell: null
    property var manifest: null
    property real cornerRadius: 0
    property bool closingFromHost: false
    property string bg: "white"
    property string fg: "black"
    property string homeDir: Quickshell.env("HOME")
    property K8sEvent lastEvent

    function open(payloadJson) {
        closingFromHost = false;
        window.visible = true;
    }

    function close() {
        closingFromHost = true;
        window.visible = false;
        closingFromHost = false;
    }

    function dismiss() {
        if (shell && typeof shell.hide === "function")
            shell.hide((manifest && manifest.id) || "havok.screen");
        else
            close();
    }

    IpcHandler {
        function close() {
            root.dismiss();
        }

        target: (root.manifest && root.manifest.id) || "havok.screen"
    }

    Process {
        command: ["fish", "-c", "kubectl -A get events -o json | jq '.items | sort_by(.lastTimestamp) | reverse | limit(1; .[])'"]
        Component.onCompleted: () => {
            this.running = true;
        }

        stdout: StdioCollector {
            onStreamFinished: () => {
                root.lastEvent.fromJson(JSON.parse(this.text));
            }
        }

    }

    FloatingWindow {
        id: window

        title: "Havok.Screen.Floating"
        color: "transparent"
        implicitWidth: 800
        implicitHeight: row.implicitHeight + row.anchors.topMargin + row.anchors.bottomMargin
        minimumSize: Qt.size(window.implicitWidth, window.implicitHeight)
        visible: false
        onVisibleChanged: {
            if (!visible && !root.closingFromHost)
                root.dismiss();

        }

        ClippingRectangle {
            id: rect

            anchors.fill: parent
            color: root.bg
            radius: root.cornerRadius

            FileView {
                id: colorsFile

                path: root.homeDir + "/.local/state/omarchy/current/theme/colors.toml"
                onLoadedOrAsyncChanged: () => {
                    let re = /dark_background\s*=\s*"(.*)"/;
                    let lines = colorsFile.text().split("\n");
                    for (const line of lines) {
                        const match = line.match(re);
                        if (match)
                            root.bg = match[1];

                    }
                    re = /dark_foreground\s*=\s*"(.*)"/;
                    lines = colorsFile.text().split("\n");
                    for (const line of lines) {
                        const match = line.match(re);
                        if (match)
                            root.fg = match[1];

                    }
                }
            }

            RowLayout {
                id: row

                anchors.fill: parent
                anchors.margins: 10

                FlatButton {
                    bg: root.bg
                    fg: root.fg
                    txt: "Ok"
                    preferredWidth: 100
                    onPressed: () => {
                    }
                }

            }

        }

    }

    lastEvent: K8sEvent {
        onLoaded: () => {
            console.log(this.metadata.name);
        }
    }

}
