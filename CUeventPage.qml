import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import io.qt.example.eventsmanager 1.0
ColumnLayout {
    property alias name: nameField.text
    property alias date : dateField.text
    property alias place : placeField.text
    property alias price : priceField.text
    property alias ticket : ticketField.text
    property alias type_event : typeEvent.displayText


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

    ComboBox {
        id: typeEvent
        model: ["Concert", "Show", "Ballet"]
    }

    RowLayout {
        Button {
            id: save
            text: "Save"
           // onClicked:SqlEventModel.saveEvent(name, date, place, price, ticket, typeEvent.currentText );
        }

        Button {
            id: remove
            text: "Remove"
        }

    }
}



