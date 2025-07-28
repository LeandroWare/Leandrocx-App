import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#00ffffff"
    Layout.fillHeight: true
    Layout.fillWidth: true
    property int contentIndex: 0
    property color textColor: "#b7c2cf"

    signal openCnpjDialog(string modelId, string text)

    StackLayout {
        anchors.fill: parent
        currentIndex: contentIndex

        //==========================================
        // DEFAULT COMPONENT
        //==========================================
        Rectangle {
            id: mainContentComponent
            color: "#00ffffff"

            ColumnLayout {
                id: contentSeparator0
                x: -202
                y: 0
                anchors.fill: parent
                Text {
                    id: contentTitle
                    color: textColor
                    text: qsTr("NEWS - Prototype 1.0 (05/30/2025)")
                    font.pixelSize: 30
                    font.styleName: "Bold"
                    font.family: "Montserrat"
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                }

                Rectangle {
                    id: contentContainer0
                    width: 200
                    height: 200
                    color: "#0000bfff"

                    Text {
                        id: newsText
                        color: textColor
                        text: qsTr("NEWS sla oq")
                        font.pixelSize: 10
                        font.family: "Montserrat"
                        Layout.topMargin: 10
                        Layout.leftMargin: 10
                    }

                    // Texto de news aqui
                    Layout.topMargin: 10
                    Layout.rightMargin: 20
                    Layout.margins: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 10
                }
            }
        }

        //==========================================
        // NEW COMPONENT
        //==========================================
        Rectangle {
            id: newComponent
            color: "#00ffffff"

            ColumnLayout {
                id: contentSeparator1
                x: -202
                y: 0
                anchors.fill: parent
                Text {
                    id: contentTitle1
                    color: textColor
                    text: qsTr("NEW DOCUMENT")
                    font.pixelSize: 30
                    font.styleName: "Bold"
                    font.family: "Montserrat"
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                }

                Rectangle {
                    id: contentContainer1
                    width: 200
                    height: 200
                    color: "#57ffffff"
                    GridLayout {
                        id: gridLayout
                        anchors.fill: parent
                        layoutDirection: Qt.LeftToRight
                        uniformCellWidths: false
                        uniformCellHeights: true
                        rows: 2
                        rowSpacing: 50
                        flow: GridLayout.LeftToRight

                        property int max_quantity: 8
                        property int quantity: 8

                        Repeater {
                            model: parent.quantity // Pode ser qualquer número menor que 15

                            BaseFileButton {
                                Layout.alignment: Qt.AlignHCenter

                            }
                        }

                        // Preenche o restante com espaços invisíveis para fixar a estrutura
                        // Isso evita que os botões ocupem mais do que deveriam
                        Repeater {
                            model: parent.max_quantity // total de células - quantos botões reais tem

                            Rectangle {
                                //visible: true // só um "placeholder"
                                color.a: 0
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 100
                            }
                        }

                        columns: 4
                        columnSpacing: 20
                    }
                    Layout.topMargin: 10
                    Layout.rightMargin: 20
                    Layout.margins: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 10
                }
            }
        }

        //==========================================
        // RECENTS COMPONENT
        //==========================================
        Rectangle {
            id: recentsComponent
            color: "#00ffffff"

            ColumnLayout {
                id: contentSeparator2
                x: -202
                y: 0
                anchors.fill: parent
                Text {
                    id: contentTitle2
                    color: textColor
                    text: qsTr("RECENT DOCUMENTS")
                    font.pixelSize: 30
                    font.styleName: "Bold"
                    font.family: "Montserrat"
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                }

                Rectangle {
                    id: contentContainer2
                    width: 200
                    height: 200
                    color: "#57ffffff"
                    GridLayout {
                        id: gridLayout2
                        anchors.fill: parent
                        layoutDirection: Qt.LeftToRight
                        uniformCellWidths: false
                        uniformCellHeights: true
                        rows: 2
                        rowSpacing: 50
                        flow: GridLayout.LeftToRight

                        property int max_quantity: 8
                        property int quantity: 8

                        Repeater {
                            model: parent.quantity // Pode ser qualquer número menor que 15

                            BaseFileButton {
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }

                        // Preenche o restante com espaços invisíveis para fixar a estrutura
                        // Isso evita que os botões ocupem mais do que deveriam
                        Repeater {
                            model: parent.max_quantity // total de células - quantos botões reais tem

                            Rectangle {
                                //visible: true // só um "placeholder"
                                color.a: 0
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 100
                            }
                        }

                        columns: 4
                        columnSpacing: 20
                    }
                    Layout.topMargin: 10
                    Layout.rightMargin: 20
                    Layout.margins: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 10
                }
            }
        }

        //==========================================
        // IMPORT COMPONENT
        //==========================================
        Rectangle {
            id: importComponent
            color: "#00ffffff"

            ColumnLayout {
                id: contentSeparator3
                x: -202
                y: 0
                anchors.fill: parent
                Text {
                    id: contentTitle3
                    color: textColor
                    text: qsTr("IMPORT DOCUMENT")
                    font.pixelSize: 30
                    font.styleName: "Bold"
                    font.family: "Montserrat"
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                }

                Rectangle {
                    id: contentContainer3
                    width: 200
                    height: 200
                    color: "#0000bfff"

                    // Text {
                    //     id: newsText
                    //     color: textColor
                    //     text: qsTr("NEWS sla oq")
                    //     font.pixelSize: 10
                    //     font.family: "Montserrat"
                    //     Layout.topMargin: 10
                    //     Layout.leftMargin: 10
                    // }

                    // Texto de news aqui
                    Layout.topMargin: 10
                    Layout.rightMargin: 20
                    Layout.margins: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 10
                }
            }
        }

        //==========================================
        // MODELS COMPONENT
        //==========================================
        Rectangle {
            id: modelsComponent
            color: "#00ffffff"

            ColumnLayout {
                id: contentSeparator4
                x: -202
                y: 0
                anchors.fill: parent
                Text {
                    id: contentTitle4
                    color: textColor
                    text: qsTr("MODELS")
                    font.pixelSize: 30
                    font.styleName: "Bold"
                    font.family: "Montserrat"
                    Layout.topMargin: 10
                    Layout.leftMargin: 10
                }

                Rectangle {
                    id: contentContainer4
                    width: 200
                    height: 200
                    color: "#57ffffff"
                    GridLayout {
                        id: gridLayout4
                        anchors.fill: parent
                        layoutDirection: Qt.LeftToRight
                        uniformCellWidths: false
                        uniformCellHeights: true
                        rows: 2
                        rowSpacing: 50
                        flow: GridLayout.LeftToRight

                        property int max_quantity: 8
                        property int quantity: 8

                        Repeater {
                            model: parent.quantity // Pode ser qualquer número menor que 15

                            BaseFileButton {
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }

                        // Preenche o restante com espaços invisíveis para fixar a estrutura
                        // Isso evita que os botões ocupem mais do que deveriam
                        Repeater {
                            model: parent.max_quantity // total de células - quantos botões reais tem

                            Rectangle {
                                //visible: true // só um "placeholder"
                                color.a: 0
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 100
                            }
                        }

                        columns: 4
                        columnSpacing: 20
                    }
                    Layout.topMargin: 10
                    Layout.rightMargin: 20
                    Layout.margins: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 10
                }
            }
        }
    }
}
