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
                text: qsTr("Export Document")
                font.pixelSize: 30
                font.styleName: "Bold"
                font.family: "Montserrat"
                anchors.fill: parent
                anchors.margins: 10
            }
        }

        Rectangle{
            id: rectangle
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Constants.backgroundColor_2

            ColumnLayout {
                id: grid
                spacing: 20
                //rowSpacing: 20
                //anchors.fill: parent
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.margins: 10
                //flow: GridLayout.TopToBottom

                Rectangle {
                    id: fileName
                    property string cnpjInfo: "Placeholder " + (index + 1)
                    property string fileName: "Default"
                    color: Constants.backgroundColor_2
                    border.width: 0

                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 100

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 5

                        Text {
                            text: "File Name"
                            color: Constants.defaultTextColor
                            font.pixelSize: 20
                        }
                        SearchBar {
                            id: fileNameField
                            placeholderText: "LeandrocxFile"
                            Layout.fillWidth: true
                            onTextChanged: {
                                parent.parent.fileName = text
                            }
                        }
                    }
                }

                Rectangle{

                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: Constants.backGroundColor_Secondary

            LeandroButton {
                id: confirmButton
                text: qsTr("Export")
                anchors.fill: parent
                anchors.margins: 10
                enabled: fileNameField.text.length >= 1

                onClicked: {
                    modelHandler.exportDocument(fileNameField.text)
                    stack.push("Screen01.qml")
                }
            }
        }
    }
}
