import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

ColumnLayout {

    property int index
    property alias code : codeLabel.text
    property alias name : nameLabel.text
    property alias date : dateLabel.text
    property alias place : placeLabel.text
    property alias price : priceLabel.text
    property alias ticket : ticketLabel.text
    property alias type : typeLabel.text


    Label {
        id: codeLabel
    }
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

    RowLayout {
        Button {
            id: editButton
            text: "Edit"
            onClicked:loadPage.setSource("CUeventPage.qml", {"index": index, "code": code, "name": name, "date": date, "place":place, "price": price,
                                             "ticket": ticket, "type": type});
        }

        Button {
            id: remove
            text: "Remove"
            onClicked: loadPage.setSource("removeItemPopup.qml", {"index": index, "code": code});
        }
    }

}


