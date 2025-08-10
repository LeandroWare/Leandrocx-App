// ContentScreen.qml  (QML “puro”, ao invés de .ui.qml)
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import LeandrocxUIDesign 1.0

Rectangle {
    id: root
    width: 800; height: 600
    color: "#00000000"

    property bool dialogVisible: false
    property string dialogModelId: "MODEL_ID"
    property string dialogText: "DIALOG_TEXT"

    signal requestConfirmation(string modelId, string text)

    function showDialog(modelId, text){
        dialogVisible = true
        dialogModelId = modelId
        dialogText = text
    }

    onDialogVisibleChanged: {
        dialogMouseArea.enabled = !dialogMouseArea.enabled
        dialogMouseArea.visible = !dialogMouseArea.visible
    }

    MouseArea {
        id: dialogMouseArea
        enabled: false
        visible: false
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
            color: Constants.backgroundColor_2
            radius: 10
            border.color: "#303d4b"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    color: "#b7c2cf"
                    text: qsTr("Enter text to model: %1").arg(root.dialogModelId)
                    font.pointSize: 28
                }

                TextField {
                    id: inputField
                    color: "#b7c2cf"
                    font.pointSize: 16
                    echoMode: TextInput.Normal
                    passwordCharacter: ""
                    placeholderTextColor: "#80ffffff"
                    placeholderText: qsTr("Insert CNPJ Here…")
                    Layout.fillWidth: true
                    background: textfieldBg // pra sobrescrever o fundo padrão
                    inputMethodHints: Qt.ImhDigitsOnly


                    Rectangle{
                        id: textfieldBg
                        color: "#0D131D"
                        border.color: "#b7c2cf"
                        radius: 12
                    }

                    // Aqui faz a mágica do CNPJ formatado
                        onTextChanged: {
                            let digits = inputField.text.replace(/\D/g, "").slice(0, 14) // só números, no máximo 14
                            let formatted = ""

                            if (digits.length > 0) formatted += digits.slice(0, 2)
                            if (digits.length > 2) formatted += "." + digits.slice(2, 5)
                            if (digits.length > 5) formatted += "." + digits.slice(5, 8)
                            if (digits.length > 8) formatted += "/" + digits.slice(8, 12)
                            if (digits.length > 12) formatted += "-" + digits.slice(12, 14)

                            if (inputField.text !== formatted)
                                inputField.text = formatted
                        }
                }

                RowLayout {
                    Layout.maximumWidth: 200
                    Layout.alignment: Qt.AlignLeft
                    spacing: 10

                    LeandroButton {
                        id: cancelButton
                        text: "Cancel"
                        outlineOnly: true
                        font.bold: false
                        icon.color: "#b7c2cf"
                        onClicked: root.dialogVisible = false
                    }

                    LeandroButton {
                        id: sendButton
                        text: qsTr("Send")
                        enabled: inputField.text.length > 0
                        onClicked: {
                            // emite para o C++ ou para quem for tratar
                            root.requestConfirmation(root.dialogModelId, inputField.text)
                            root.dialogVisible = false
                            inputField.text = ""
                            stack.push("Screen02_cnpj.qml")
                        }
                    }
                }
            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
