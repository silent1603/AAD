import QtQuick 2.0

Item {
    id: root;

    Rectangle {
        width: 1920 * appConfig.width_ratio
        height: (1200-140) * appConfig.height_ratio
        color: "white"
    }
}
