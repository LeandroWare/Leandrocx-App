

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import LeandrocxUIDesign 1.0
import QtQuick.Layouts
import QtQuick3D 6.8
import QtQuick3D.AssetUtils
import QtQuick.Studio.DesignEffects
import QtQuick.Studio.Components
import QtQuick.Studio.Utils

Rectangle {
    width: Constants.width
    height: Constants.height
    anchors.fill: parent

    // Responsivo com o tamanho da janela
    color: Constants.separateLineColor
    Item {
        id: __materialLibrary__
    }

    ColumnLayout {
        id: mainLayout
        property int leftBarWidth: 200
        property int globalSpacing: 2
        anchors.fill: parent
        spacing: globalSpacing

        Rectangle {
            id: topContainerRectangle
            color: Constants.separateLineColor
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.maximumHeight: 50

            RowLayout {
                id: topContainer
                anchors.fill: parent
                spacing: mainLayout.globalSpacing

                Rectangle {
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: false
                        focusPolicy: Qt.NoFocus
                        onClicked: contentScreen.contentIndex = 0
                        cursorShape: Qt.PointingHandCursor
                    }

                    id: menuRectangle
                    color: Constants.backGroundColor_Secondary

                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredWidth: mainLayout.leftBarWidth

                    Text {
                        id: menuText
                        color: "#8291a2"
                        text: qsTr("Leandrocx")
                        anchors.fill: parent
                        anchors.leftMargin: 15
                        font.pixelSize: 26
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        style: Text.Outline
                        font.styleName: "Bold"
                        font.weight: Font.Normal
                        font.family: "Montserrat"
                    }
                }

                Rectangle {
                    id: searchRectangle
                    color: Constants.backGroundColor_Secondary
                    Layout.topMargin: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    SearchBar {
                        id: searchBar
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 7
                        anchors.topMargin: 7
                        anchors.bottomMargin: 7
                    }
                }
            }
        }

        Rectangle {
            id: bottomContainerRectangle
            color: Constants.separateLineColor

            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                id: bottomContainer
                anchors.fill: parent
                spacing: mainLayout.globalSpacing

                Rectangle {
                    id: optionsRectangle
                    color: Constants.backgroundColor_2
                    Layout.fillHeight: true
                    Layout.preferredWidth: mainLayout.leftBarWidth

                    ColumnLayout {
                        id: columnLayout
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                        spacing: 10

                        BaseButton {
                            id: newButton
                            text: "New"
                            Layout.fillWidth: true
                            onClicked: contentScreen.contentIndex = 1
                        }

                        BaseButton {
                            id: recentsButton
                            text: "Recents"
                            iconSource: "images/clockIcon.svg"
                            Layout.fillWidth: true
                            onClicked: contentScreen.contentIndex = 2
                        }

                        BaseButton {
                            id: newButton1
                            text: "Import"
                            iconSource: "images/importIcon.svg"
                            Layout.fillWidth: true
                            onClicked: contentScreen.contentIndex = 3
                        }

                        BaseButton {
                            id: newButton2
                            text: "Models"
                            iconSource: "images/modelsIcon.svg"
                            Layout.fillWidth: true
                            onClicked: contentScreen.contentIndex = 4
                        }

                        BaseButton {
                            id: newButton3
                            text: "Exit"
                            iconSource: "images/exitIcon.svg"
                            Layout.fillWidth: true
                        }
                    }
                }

                Rectangle {
                    id: contentRectangle
                    color: Constants.backgroundColor_1
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ContentScreen {
                        id: contentScreen
                    }
                }
            }
        }
    }
}
