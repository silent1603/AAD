import QtQuick 2.11
import QtQuick.Window 2.0
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 1920 * appConfig.width_ratio
    height: 1200 * appConfig.height_ratio
    Image {
        id: background
        width: 1920 * appConfig.width_ratio
        height: 1200 * appConfig.height_ratio
        source: "qrc:/Img/bg_full.png"
    }

    StatusBar {
        id: statusBar
        onBntBackClicked: stackView.pop()
        isShowBackBtn: stackView.depth == 1 ? false : true
    }

    StackView {
        id: stackView
        width: 1920 * appConfig.width_ratio
        anchors.top: statusBar.bottom
        initialItem: HomeWidget{}
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -(1920 * appConfig.width_ratio)
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
        Keys.onPressed: {
            switch (event.key){
                case Qt.Key_Backspace:
                    if (statusBar.isShowBackBtn === true) statusBar.bntBackClicked()
                    break;
                case Qt.Key_Home:
                    while (stackView.depth > 1) stackView.pop()
                    break;
                case Qt.Key_PageUp:
                    mController.volumnUp()
                    break;
                case Qt.Key_PageDown:
                    mController.volumnDown();
                    break;
                case Qt.Key_End:
                    mController.volumnMute();
                    break;
                case Qt.Key_Space:
                    mController.play();
                    break;

            }
        }
    }
}
