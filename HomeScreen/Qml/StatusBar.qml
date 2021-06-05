import QtQuick 2.0
import QtQuick.Layouts 1.11
import "Common"
import QtQml 2.2

Item {
    width: 1920 * appConfig.width_ratio
    height: 104 * appConfig.height_ratio
    signal bntBackClicked
    property bool isShowBackBtn: false
    Button {
        anchors.left: parent.left
        icon: "qrc:/Img/StatusBar/btn_top_back"
        width: 135 * appConfig.width_ratio
        height: 101 * appConfig.height_ratio
        iconWidth: width
        iconHeight: height
        onClicked: bntBackClicked()
        visible: isShowBackBtn
    }

    Item {
        id: clockArea
        x: 660 * appConfig.width_ratio
        width: 300 * appConfig.width_ratio
        height: parent.height
        Image {
            anchors.left: parent.left
            height: 104 * appConfig.height_ratio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
        Text {
            id: clockTime
            text: "10:28"
            color: "white"
            font.pixelSize: 72 * appConfig.height_ratio
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104 * appConfig.height_ratio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }
    Item {
        id: dayArea
        anchors.left: clockArea.right
        width: 300 * appConfig.width_ratio
        height: parent.height
        Text {
            id: day
            text: "Jun. 24"
            color: "white"
            font.pixelSize: 72 * appConfig.height_ratio
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104 * appConfig.height_ratio
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }

    QtObject {
        id: time
        property var locale: Qt.locale()
        property date currentTime: new Date()

        Component.onCompleted: {
            clockTime.text = currentTime.toLocaleTimeString(locale, "hh:mm");
            day.text = currentTime.toLocaleDateString(locale, "MMM. dd");
        }
    }

    Timer{
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            time.currentTime = new Date()
            clockTime.text = time.currentTime.toLocaleTimeString(locale, "hh:mm");
            day.text = time.currentTime.toLocaleDateString(locale, "MMM. dd");
        }

    }

}
