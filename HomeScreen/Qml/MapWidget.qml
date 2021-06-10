import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6
MouseArea {
    id: root
    preventStealing: true
    propagateComposedEvents: true
    property bool isFocusing : false
    implicitWidth: 635 * appConfig.width_ratio
    implicitHeight: 570 * appConfig.height_ratio
    //drag.target: parent
    Rectangle {
        anchors{
            fill: parent

        }
        opacity: 0.1
        color: "#111419"
    }
    Item {
        id: map
        x: 10 * appConfig.width_ratio
        y: 10 * appConfig.height_ratio
        width: 615 * appConfig.width_ratio
        height: 550 * appConfig.height_ratio
        Plugin {
            id: mapPlugin
            name: "mapboxgl" //"osm" // , "esri", ...
        }
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width/4
            anchorPoint.y: image.height
            coordinate: QtPositioning.coordinate(21.03, 105.78)

            sourceItem: Image {
                id: image
                source: "qrc:/Img/Map/car_icon.png"
            }
        }
        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(21.03, 105.78)
            zoomLevel: 14
            copyrightsVisible: false
            enabled: false
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }
    }
    Image {
        id: idBackgroud

        width: root.width
        height: root.height

        source: ""
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        if (!root.isFocusing) root.state = "Normal"
        else root.state = "Focus"
    }
    onFocusChanged: {
        if (root.isFocusing == true )root.state = "Focus"
        else root.state = "Normal"
    }
    function updateFocus()
    {
        if(root.isFocusing) root.state = "Focus"
        else root.state = "Normal"
    }
}
