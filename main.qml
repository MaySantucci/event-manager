import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1040
    height: 680
    title: qsTr("Event Manager")

    EventManagerPage {
        anchors.fill: parent
    }


}
