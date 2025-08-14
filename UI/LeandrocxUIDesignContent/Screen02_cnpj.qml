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

                ListModel {
                    id: camposCnpj
                    ListElement { titulo: "CNPJ"; getter: "cnpj" }
                    ListElement { titulo: "Razão Social"; getter: "razaoSocial" }
                    ListElement { titulo: "Nome Fantasia"; getter: "nomeFantasia" }
                    ListElement { titulo: "Atividade Principal"; getter: "atvPrincipal" }
                    ListElement { titulo: "Status"; getter: "status" }
                    ListElement { titulo: "Telefone"; getter: "telefone" }
                    ListElement { titulo: "Rua"; getter: "rua" }
                    ListElement { titulo: "Número"; getter: "num" }
                    ListElement { titulo: "Bairro"; getter: "bairro" }
                    ListElement { titulo: "CEP"; getter: "cep" }
                    ListElement { titulo: "Cidade"; getter: "cidade" }
                    ListElement { titulo: "Estado"; getter: "estado" }
                }

                Repeater {
                    model: camposCnpj
                    delegate: Rectangle {
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
                                text: titulo
                                color: Constants.defaultTextColor
                                font.pixelSize: 16
                            }

                            SearchBar {
                                text: cnpjHandler[getter] || "NULL"
                                Layout.fillWidth: true

                                onTextChanged: {
                                    cnpjHandler[getter] = text
                                }
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
                    cnpjHandler.updateCnpjData();
                    modelHandler.CreatePassiveModel();
                    stack.push("Screen03_Editor.qml")
                }
            }
        }
    }
}
