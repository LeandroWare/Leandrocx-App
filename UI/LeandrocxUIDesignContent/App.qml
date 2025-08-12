import QtQuick
import QtQuick.Controls
import LeandrocxUIDesign

Window {
    property int minWidth: 1280
    property int minHeight: 720
    property int defaultHeight: 720
    property int defaultWidth: 1280

    width: defaultWidth
    height: defaultHeight
    minimumWidth: minWidth
    minimumHeight: minHeight

    visible: true
    title: "LeandrocxUIDesign"

    // Gerenciador das telas
    StackView{
        id: stack
        anchors.fill: parent
        initialItem: Screen01{
            id: mainScreen
        }



    }
}
