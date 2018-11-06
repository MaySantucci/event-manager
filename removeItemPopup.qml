import QtQuick 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.4

Dialog {
    id: root

    property int index

    title: "Remove item"

    Label {
        text: "Are you sure to remove this item? "
        anchors.centerIn: parent
    }

    standardButtons: StandardButton.Yes | StandardButton.No

    Component.onCompleted: visible = true

    onAccepted: {
        myDb.removeEvent(root.index, root.code);

        root.close();
    }
    onRejected: {
        root.close();
    }

}
