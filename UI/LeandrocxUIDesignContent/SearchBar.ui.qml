

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

Rectangle {
    id: root
    width: 300
    height: 40
    color.a: 0

    property alias text: searchField.text
    property alias placeholderText: searchField.placeholderText
    property alias backgroundColor: background.color
    property alias font: searchField.font

    property color textColorNormal: "#343e4f"
    property color textColorHover: "#b7c2cf"
    property color bgColorNormal: "#001e1e1e"
    property color bgColorFocus: "#0D131D"
    property color borderColorNormal: "#384554"
    property color borderColorFocus: "#b7c2cf"

    Rectangle {
        id: background
        anchors.fill: parent
        color: bgColorNormal
        radius: 12
        border.color: "#171e29"
        border.width: 1
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        spacing: 8

        Image {
            id: icon

            source: "images/searchIcon.svg"
            Layout.leftMargin: 8
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit
        }

        // Text {
        //     id: icon
        //     text: "\uE8B6"
        // anchors.left: parent.left
        // anchors.top: parent.top
        // anchors.bottom: parent.bottom
        // anchors.leftMargin: 8
        // anchors.topMargin: 4
        // anchors.bottomMargin: 0
        //     // search
        //     font.family: materialIcons.name
        //     font.pixelSize: 20
        //     color: textColorNormal
        //     verticalAlignment: Text.AlignVCenter
        //     style: Text.Normal
        // }
        TextField {
            id: searchField
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            echoMode: TextInput.Normal
            Layout.rightMargin: 8
            placeholderTextColor: "#343e4f"
            hoverEnabled: true
            placeholderText: "Pesquisar"
            background: null
            selectionColor: "#00343e4f"
            selectedTextColor: "#00343e4f"
            color: "white"

            selectByMouse: true
            clip: false

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            // TODO
            // onTextChanged: doSearch()
        }
    }

    Item {
        id: __materialLibrary__
    }

    // Animação quando focado
    states: [
        State {
            name: "focused"
            when: searchField.focus

            // PropertyChanges {
            //     target: icon
            //     color: textColorHover
            // }
            PropertyChanges {
                target: searchField
                color: textColorHover
                placeholderTextColor: textColorHover
            }

            PropertyChanges {
                target: background
                color: bgColorFocus
                border.color: borderColorFocus
            }
        },
        State {
            name: "normal"
            when: !searchField.focus

            PropertyChanges {
                target: searchField
                color: textColorNormal
                placeholderTextColor: textColorNormal
            }

            // PropertyChanges {
            //     target: icon
            //     color: textColorNormal
            // }
            PropertyChanges {
                target: background
                color: bgColorNormal
                border.color: borderColorNormal
            }
        }
    ]
}
