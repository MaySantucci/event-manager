import QtQuick 2.2
import QtQuick.Dialogs 1.1

MessageDialog {
    id: messageDialog

    property int index
    property int code

    title: "Remove item"
    text: "Are you sure to remove this item? "

    standardButtons: StandardButton.Yes | StandardButton.No

    Component.onCompleted: visible = true

    onYes: {
        console.log("Remove element.")
        myDb.removeEvent(messageDialog.index, messageDialog.code);

        messageDialog.close();
    }
    onNo: {
        messageDialog.close();
    }

}
