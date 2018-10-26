import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

ColumnLayout {
    Label {
        id: nameLabel
        text:"name"
    }
    Label {
        id: dateLabel
        text:"date"
    }
    Label {
        id: placeLabel
        text:"place"
    }
    Label {
        id: priceLabel
        text:"price"
    }
    Label {
        id: ticketLabel
        text:"ticket"
    }

    Button {
        id: editButton
        text: "Edit"
        onClicked:loadPage.setSource("CRUeventPage.qml");
    }

}


