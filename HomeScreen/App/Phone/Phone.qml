import QtQuick 2.0

Item {
    width: 1920 * appConfig.width_ratio
    height: (1200-104) * appConfig.height_ratio
    Rectangle{
        width: parent.width
        height: 104 * appConfig.height_ratio
        color: "#2B2937"
        Text {
            text: qsTr("Phone")
            anchors.centerIn: parent
            font.pointSize: 17
            color: "white"
        }
    }
}
