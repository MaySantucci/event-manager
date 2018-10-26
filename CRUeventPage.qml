import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

ColumnLayout {
    id: cruEvent

    TextField {
        id: name
        placeholderText: qsTr("name")
    }
    TextField {
        id: date
        placeholderText: qsTr("date")
    }
    TextField {
        id: place
        placeholderText: qsTr("place")
    }
    TextField {
        id: price
        placeholderText: qsTr("price")
    }
    TextField {
        id: ticket
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



