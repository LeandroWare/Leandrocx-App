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

                        Item{
                            Layout.fillWidth: true
                            height: 40

                            TextField {
                                id: inputField
                                color: "#384554"
                                anchors.fill: parent
                                font.pointSize: 12
                                echoMode: TextInput.Normal
                                passwordCharacter: ""
                                placeholderTextColor: "#343e4f"
                                placeholderText: qsTr("LeandrocxFile")
                                Layout.fillWidth: true
                                background: textfieldBg // pra sobrescrever o fundo padrão
                                inputMethodHints: Qt.ImhNone

                                validator: RegularExpressionValidator {
                                        regularExpression: /^[A-Za-z0-9_-]*$/
                                    }

                                Rectangle{
                                    id: textfieldBg
                                    color: "#00000000"
                                    border.color: "#384554"
                                    radius: 12
                                }
                            }

                            // Animação quando focado
                            states: [
                                State {
                                    name: "focused"
                                    when: inputField.focus

                                    // PropertyChanges {
                                    //     target: icon
                                    //     color: textColorHover
                                    // }
                                    PropertyChanges {
                                        target: inputField
                                        color: "#b7c2cf"
                                        placeholderTextColor: "#b7c2cf"
                                    }

                                    PropertyChanges {
                                        target: textfieldBg
                                        color: "#0d131d"
                                        border.color: "#b7c2cf"
                                    }
                                },
                                State {
                                    name: "normal"
                                    when: !inputField.focus

                                    PropertyChanges {
                                        target: inputField
                                        color: "#343e4f"
                                        placeholderTextColor: "#343e4f"
                                    }

                                    // PropertyChanges {
                                    //     target: icon
                                    //     color: textColorNormal
                                    // }
                                    PropertyChanges {
                                        target: textfieldBg
                                        color: "#001e1e1e"
                                        border.color: "#384554"
                                    }
                                }
                            ]
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
                text: qsTr("Export")
                anchors.fill: parent
                anchors.margins: 10
                enabled: inputField.text.length >= 1

                onClicked: {
                    modelHandler.exportDocument(inputField.text)
                    stack.push("Screen01.qml")
                }
            }
        }
    }
}
