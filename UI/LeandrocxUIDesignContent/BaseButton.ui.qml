

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Studio.DesignEffects

Button {
    id: control

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "Text"
    property color hoverColor: "#171E29"
    property color hoverBorderColor: "#303D4B"
    property url iconSource: "images/fileIcon.svg"

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        opacity: 0
        color: hoverColor
        implicitWidth: 100
        implicitHeight: 40
        radius: 8
        border.color: hoverBorderColor
        border.width: 1

        DesignEffect {
            effects: [
                DesignDropShadow {
                    visible: true
                    color: "#88000000"
                    offsetY: 5
                    blur: 6
                }
            ]
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }

    contentItem: textItem
    Text {
        id: textItem
        anchors.left: image.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 4

        opacity: enabled ? 1.0 : 0.3
        color: "#b7c2cf"
        text: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 15
        font.styleName: "Medium"
        font.family: "Montserrat"
    }

    Image {
        id: image
        width: 25
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 4
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        source: control.iconSource
        sourceSize.height: 135
        fillMode: Image.PreserveAspectFit
    }

    states: [
        State {
            name: "hover"
            when: control.hovered

            PropertyChanges {
                target: textItem
                font.styleName: "Bold"
            }
        },
        State {
            name: "normal"
            when: !control.hovered

            PropertyChanges {
                target: textItem
                font.styleName: "Medium"
            }
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "hover"

            NumberAnimation {
                target: buttonBackground
                property: "opacity"
                from: buttonBackground.opacity
                to: 1.0
                duration: 150
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "hover"
            to: "normal"

            NumberAnimation {
                target: buttonBackground
                property: "opacity"
                from: buttonBackground.opacity
                to: 0.0
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
