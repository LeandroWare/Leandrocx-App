
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Studio.DesignEffects
import QtQuick.Layouts

Button {
    id: control

    leftPadding: 4
    rightPadding: 4

    text: ""
    property string sdasd: "Texto ok"
    property color hoverColor: "#171E29"
    property color hoverBorderColor: "#303D4B"
    property url iconSource: "images/fileIcon.svg"
    property int imageMaring: 25

    implicitWidth: 165
    //Layout.minimumHeight: 600 //165
    implicitHeight: 215
    //Layout.preferredHeight: 327
    //Layout.minimumWidth: 800 //145

    //Layout.preferredWidth: 275
    background: buttonBackground
    Rectangle {
        id: buttonBackground
        opacity: 1
        color: hoverColor
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

        Rectangle {
            id: rectangle
            color: "#00a43131"
            border.color: "#00000000"

            //Layout.fillHeight: true
            //Layout.fillWidth: true
            anchors.fill: parent
            anchors.leftMargin: control.imageMaring
            anchors.rightMargin: control.imageMaring
            anchors.topMargin: control.imageMaring
            anchors.bottomMargin: control.imageMaring

            Rectangle {
                id: imageRectangle
                color: "#001341"
                border.color: "#000000"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.minimumHeight: 100
                Layout.maximumHeight: 550

                //color.a: 0
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top

                Image {
                    id: image
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                   // anchors.bottom: parent.bottom
                    //anchors.bottomMargin: control.imageMaring

                    //anchors.fill: parent

                    //sourceSize.height: 225
                    source: "images/EmptyFileIcon.svg"
                    //sourceSize.width: 10
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: textItem
                    opacity: enabled ? 1.0 : 0.3
                    color: "#b7c2cf"
                    text: control.sdasd

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: image.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 8

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    font.styleName: "Medium"
                    font.pointSize: 18
                    font.family: "Montserrat"
                }
            }
        }
    }

    // states: [
    //     State {
    //         name: "hover"
    //         when: control.hovered
    //     },
    //     State {
    //         name: "normal"
    //         when: !control.hovered
    //     }
    // ]

    // transitions: [
    //     Transition {
    //         from: "normal"
    //         to: "hover"

    //         NumberAnimation {
    //             target: buttonBackground
    //             property: "opacity"
    //             from: buttonBackground.opacity
    //             to: 1.0
    //             duration: 150
    //             easing.type: Easing.InOutQuad
    //         }
    //     },
    //     Transition {
    //         from: "hover"
    //         to: "normal"

    //         NumberAnimation {
    //             target: buttonBackground
    //             property: "opacity"
    //             from: buttonBackground.opacity
    //             to: 0.0
    //             duration: 150
    //             easing.type: Easing.InOutQuad
    //         }
    //     }
    // ]
}
