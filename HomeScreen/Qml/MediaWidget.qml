import QtQuick 2.0
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    property bool isFocusing : false
    implicitWidth: 635 * appConfig.width_ratio
    implicitHeight: 570 * appConfig.height_ratio
    //drag.target: parent
    Rectangle {
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10 * appConfig.width_ratio
        y:10 * appConfig.height_ratio
        width: 615 * appConfig.width_ratio
        height: 550 * appConfig.height_ratio
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40 * appConfig.height_ratio
        text: "USB Music"
        color: "white"
        font.pixelSize: 34
    }
    Image {
        id: bgInner
        x:201 * appConfig.width_ratio
        y:119 * appConfig.height_ratio
        width: 258 * appConfig.width_ratio
        height: 258 * appConfig.height_ratio
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:201 * appConfig.width_ratio
        y:119 * appConfig.height_ratio
        width: 258 * appConfig.width_ratio
        height: 258 * appConfig.height_ratio
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42 * appConfig.width_ratio
        y: (56+343) * appConfig.height_ratio
        width: 551 * appConfig.width_ratio
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
        }
        color: "white"
        font.pixelSize: 30 * appConfig.height_ratio
    }
    Text {
        id: txtTitle
        x: 42 * appConfig.height_ratio
        y: (56+343+55) * appConfig.height_ratio
        width: 551 * appConfig.width_ratio
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount()() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 48 * appConfig.height_ratio
    }
    Image{
        id: imgDuration
        x: 62 * appConfig.width_ratio
        y: (56+343+55+62) * appConfig.height_ratio
        width: 511 * appConfig.width_ratio
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62 * appConfig.width_ratio
        y: (56+343+55+62) * appConfig.height_ratio
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
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
        if (root.isFocusing == true )root.state = "Focus"
        else root.state = "Normal"
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
    Connections{
        target: player.playlist
        onCurrentIndexChanged:{
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex) {
                bgBlur.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                bgInner.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                txtSinger.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
                txtTitle.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511);
        }
    }
}
