import QtQuick
import QtQuick.Layouts

Item {
    id: btn

    property bool isHover: false
    property bool isClicked: false
    property string bg: "black"
    property string fg: "white"
    property string txt: "no txt"
    property int preferredWidth: 100
    property int preferredHeight: btn.width / 4

    signal pressed()
    signal released()

    Layout.preferredWidth: btn.preferredWidth
    Layout.preferredHeight: btn.preferredHeight

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onEntered: () => {
            btn.isHover = true;
        }
        onExited: () => {
            btn.isHover = false;
        }
        onPressed: (mouseEvent) => {
            btn.isClicked = true;
            btn.pressed();
        }
        onReleased: () => {
            btn.isClicked = false;
            btn.released();
        }
    }
       

    Rectangle {
        anchors.fill: parent
        border.color: fg
        color: {
            if (btn.isClicked)
                return Qt.darker(btn.bg, 1.2);

            if (btn.isHover)
                return Qt.lighter(btn.bg, 1.2);

            return btn.bg;
        }
    }

    Text {
        text: btn.txt
        anchors.centerIn: parent
        color: fg
    }

}
