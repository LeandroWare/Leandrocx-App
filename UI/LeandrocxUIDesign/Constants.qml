pragma Singleton
import QtQuick
import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1280
    readonly property int height: 720

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    // Colors
    readonly property color separateLineColor: "#070505"
    readonly property color backgroundColor_1: "#141A23"
    readonly property color backgroundColor_2: "#0D131D"
    readonly property color backGroundColor_Secondary: "#171E29"
    readonly property color defaultTextColor: "#BAC8D3"

    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../LeandrocxUIDesignContent/" + relativeFontDirectory)
    }
}
