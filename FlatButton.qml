import QtQuick
import QtQuick.Layouts

Item {
    id: btn

    property bool isHover: false
    property string bg: "black"
    property string fg: "white"

    Layout.preferredWidth: 100
    Layout.preferredHeight: btn.width / 4

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: () => {
            btn.isHover = true;
        }
        onExited: () => {
            btn.isHover = false;
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: fg
        color: btn.isHover ? Qt.lighter(bg, 1.5) : bg
    }

    Text {
        text: "Ok"
        anchors.centerIn: parent
        color: fg
    }

}
