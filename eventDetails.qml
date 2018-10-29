import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

ColumnLayout {

    property alias name : nameLabel.text
    property alias date : dateLabel.text
    property alias place : placeLabel.text
    property alias price : priceLabel.text
    property alias ticket : ticketLabel.text
    property alias type_event : typeLabel.text


    Label {
        id: nameLabel
    }
    Label {
        id: dateLabel
    }
    Label {
        id: placeLabel
    }
    Label {
        id: priceLabel
    }
    Label {
        id: ticketLabel
    }
    Label {
        id: typeLabel
    }

    Button {
        id: editButton
        text: "Edit"
        onClicked:loadPage.setSource("CUeventPage.qml", {"name": name, "date": date, "place":place, "price": price,
                                         "ticket": ticket, "type_event": type_event});
    }

}


