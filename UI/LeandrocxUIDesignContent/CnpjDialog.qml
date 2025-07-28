// ContentScreen.qml  (QML “puro”, ao invés de .ui.qml)
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 800; height: 600
    color: "#00000000"

    property bool dialogVisible: false
    property string dialogModelId: "NULL"
    property string dialogText: "NULL"

    signal requestConfirmation(string modelId, string text)

    onDialogVisibleChanged: {
        dialogMouseArea.enabled = !dialogMouseArea.enabled
    }

    MouseArea {
        id: dialogMouseArea
        enabled: false
        anchors.fill: parent
    }

    // — OVERLAY “DIALOG” —
    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#80000000"           // semitransparente
        visible: root.dialogVisible
        z: 100

        Rectangle {
            id: panel
            width: parent.width * 0.6
            height: 200
            anchors.centerIn: parent
            color: "#ffffff"
            radius: 8
            border.color: "#888"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: qsTr("Digite o texto para %1").arg(root.dialogModelId)
                    font.pointSize: 14
                }

                TextField {
                    id: inputField
                    placeholderText: qsTr("Escreva aqui…")
                    Layout.fillWidth: true
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: qsTr("Cancelar")
                        onClicked: root.dialogVisible = false
                    }
                    Button {
                        text: qsTr("OK")
                        enabled: inputField.text.length > 0
                        onClicked: {
                            // emite para o C++ ou para quem for tratar
                            root.requestConfirmation(root.dialogModelId, inputField.text)
                            root.dialogVisible = false
                            inputField.text = ""
                        }
                    }
                }
            }
        }
    }
}
