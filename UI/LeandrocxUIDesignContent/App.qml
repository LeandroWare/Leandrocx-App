import QtQuick
import LeandrocxUIDesign

Window {
    property int minWidth: 800
    property int minHeight: 600
    property int defaultHeight: 720
    property int defaultWidth: 1280

    width: defaultWidth
    height: defaultHeight
    minimumWidth: minWidth
    minimumHeight: minHeight

    visible: true
    title: "LeandrocxUIDesign"

    Screen01 {
        id: mainScreen
    }

}
