import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

ColumnLayout {
    property alias name: nameField.text
    property alias date : dateField.text
    property alias place : placeField.text
    property string price : priceField.text
    property string ticket : ticketField.text

    TextField {
        id: nameField
        placeholderText: qsTr("name")
    }
    TextField {
        id: dateField
        placeholderText: qsTr("date")
    }
    TextField {
        id: placeField
        placeholderText: qsTr("place")
    }
    TextField {
        id: priceField
        placeholderText: qsTr("price")
    }
    TextField {
        id: ticketField
        placeholderText: qsTr("available ticket")
    }
    RowLayout {
        Button {
            id: save
            text: "Save"
        }

        Button {
            id: remove
            text: "Remove"
        }

    }
}


