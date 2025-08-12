import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import LeandrocxUIDesign

Rectangle {
    id: root
    height: 720
    color: "#000000" // trocar dps
    width: 1280 // trocar dps
    anchors.fill: parent

    RowLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 2

        Rectangle {
            // menor
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Constants.backgroundColor_2
            radius: 0
            Text{
                anchors.centerIn: parent
                text: "PREVIEW"
                font.pointSize: 46
                color: Constants.defaultTextColor
                opacity: 0.2
            }
        }

        Rectangle {
            id: rectangle
            // maior
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            color: "#000000"
            radius: 0

            ColumnLayout{
                anchors.fill: parent
                spacing: 2

                Rectangle{
                    id: propertiesContent
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Constants.backgroundColor_1

                    Text{
                        text: "Properties Here"
                        anchors.centerIn: parent
                        font.pixelSize: 46
                        color: Constants.defaultTextColor
                        opacity: 0.2
                    }
                }

                Rectangle{
                    id: nextButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    color: Constants.backGroundColor_Secondary

                    LeandroButton{
                        text: "Next"
                        anchors.fill: parent
                        anchors.margins: 10
                        outlineOnly: false

                        onClicked: {
                            stack.push("Screen04_Export.qml")
                        }
                    }
                }
            }
        }
    }
}
