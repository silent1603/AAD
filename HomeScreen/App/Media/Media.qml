import QtQuick 2.6
import QtQuick.Controls 2.4

Item {
    width: 1920 * appConfig.width_ratio
    height: (1200 -104)* appConfig.height_ratio
    //Header
    AppHeader{
        id: headerItem
        width: parent.width
        height: 141 * appConfig.width_ratio
        playlistButtonStatus: playlist.opened ? 1 : 0
        onClickPlaylistButton: {
            if (!playlist.opened) {
                playlist.open()
            } else {
                playlist.close()
            }
        }
    }

    //Playlist
    PlaylistView{
        id: playlist
        y: (headerItem.height + 104)* appConfig.width_ratio
        width: 675 * appConfig.width_ratio
        height: (parent.height-headerItem.height-104) * appConfig.width_ratio
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: playlist.position*playlist.width
        anchors.bottom: parent.bottom
    }
}
