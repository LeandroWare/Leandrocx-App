import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import LeandrocxUIDesign

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "#000000"
    anchors.fill: parent

    ColumnLayout {
        id: contentSeparator1
        anchors.fill: parent
        spacing: 2

        Rectangle{
            anchors.top: parent.top
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: Constants.backgroundColor_1

            Text {
                id: contentTitle1
                color: Constants.defaultTextColor
                text: qsTr("Confirm Informations")
                font.pixelSize: 30
                font.styleName: "Bold"
                font.family: "Montserrat"
                anchors.fill: parent
                anchors.margins: 10
            }
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Constants.backgroundColor_2

            GridLayout {
                id: grid
                columns: 4
                columnSpacing: 20
                rowSpacing: 20
                anchors.fill: parent
                anchors.margins: 10

                Repeater {
                    model: 11  // quantidade de cards
                    delegate: Rectangle {
                        property string cnpjInfo: "Placeholder " + (index + 1)
                        color: Constants.backgroundColor_2
                        radius: 8
                        border.color: Constants.backGroundColor_Secondary

                        Layout.preferredWidth: 300
                        Layout.preferredHeight: 100

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 5

                            Text {
                                text: cnpjInfo
                                color: Constants.defaultTextColor
                                font.pixelSize: 16
                            }
                            SearchBar {
                                text: cnpjInfo
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: Constants.backGroundColor_Secondary

            LeandroButton {
                id: confirmButton
                text: qsTr("Confirm >> ")
                enabled: true
                anchors.fill: parent
                anchors.margins: 10

                onClicked: {
                    stack.push("Screen03_Editor.qml")
                }
            }
        }
    }
}
