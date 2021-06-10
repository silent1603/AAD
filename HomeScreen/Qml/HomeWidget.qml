import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

Item {
    id: root
    width: 1920 * appConfig.width_ratio
    height: 1096 * appConfig.height_ratio
    function openApplication(url){
        parent.push(url)
    }

    property var focusWidget

    function changeFocus(fw)
    {
        if(focusWidget !== undefined)
        {

             focusWidget.isFocusing = false
             focusWidget.updateFocus()
        }
        focusWidget = fw

        focusWidget.isFocusing = true
        focusWidget.updateFocus()
    }

    ListView {
        id: lvWidget
        spacing: 5 * appConfig.width_ratio
        leftMargin: 10 * appConfig.width_ratio
        rightMargin:  3 * appConfig.width_ratio
        orientation: ListView.Horizontal
        width: parent.width -spacing
        height: 570 * appConfig.height_ratio
        interactive: false

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModelWidget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }

            delegate: DropArea {
                id: delegateRootWidget
                width: 635 * appConfig.width_ratio
                height: 570 * appConfig.height_ratio
                keys: ["widget"]

                onEntered: {
                    visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex)
                    iconWidget.item.enabled = false
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: iconWidget; property: "visualIndex"; value: visualIndex }
                onExited: iconWidget.item.enabled = true
                onDropped: {
                    console.log(drop.source.visualIndex)
                }

                Loader {
                    id: iconWidget
                    property int visualIndex: 0
                    width: 635 * appConfig.width_ratio
                    height: 570 * appConfig.height_ratio
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                    Drag.active: iconWidget.item.drag.active
                    Drag.keys: "widget"
                    Drag.hotSpot.x: delegateRootWidget.width/2
                    Drag.hotSpot.y: delegateRootWidget.height/2

                    states: [
                        State {
                            when: iconWidget.Drag.active
                            ParentChange {
                                target: iconWidget
                                parent: root
                            }

                            AnchorChanges {
                                target: iconWidget
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                id: mapWidgetItem
                onClicked: {
                    console.log("press map")
                    changeFocus(mapWidgetItem)
                    openApplication("qrc:/App/Map/Map.qml")
               }
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
                id: climateWidgetItem
                onClicked: {
                     changeFocus(climateWidgetItem)
                    openApplication("qrc:/App/Climate/Climate.qml")

                }
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                id:mediaWidgetItem
                onClicked: {
                    changeFocus(mediaWidgetItem)
                    openApplication("qrc:/App/Media/Media.qml")

                }
            }
        }
    }
    ScrollBar{
        id: scrollBar
        width: lvApps.width
        height: 23 * appConfig.h_ratio
        anchors.top: lvApps.top
        anchors.left: lvApps.left
        visible: visualModel.count > 6
        orientation: Qt.Horizontal
    }

    ListView {
        id : lvApps
        x: 0 * appConfig.width_ratio
        y:570 * appConfig.height_ratio
        width: 1920 * appConfig.width_ratio
        height: 604 * appConfig.height_ratio
        orientation: ListView.Horizontal
        interactive: scrollBar.visible
        spacing: 4 * appConfig.width_ratio
        clip: true

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316 * appConfig.width_ratio
                height: 604 * appConfig.height_ratio
                keys: "AppButton"

                onEntered:{
                    appsModel.move(drag.source.visualIndex, icon.visualIndex)
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                    appsModel.saveApps()
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 316 *appConfig.width_ratio
                    height: 604 * appConfig.height_ratio
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: model.title
                        icon: model.iconPath
                        drag.target: icon
                        onClicked: openApplication(model.url)
                        onReleased: {
                            app.focus = true
                            app.state = "Focus"
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex)
                                    visualModel.items.get(index).focus = false
                                else
                                    visualModel.items.get(index).focus = true
                            }
                        }
                    }

                    onFocusChanged: app.focus = icon.focus

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"
                    Drag.hotSpot.x:app.width /2
                    Drag.hotSpot.y: app.height/2
                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }
        ScrollBar.horizontal: scrollBar
    }
}
