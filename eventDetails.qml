import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

import io.qt.example.eventsmanager 1.0

ColumnLayout {
    id: root
    property int index
    property alias code : codeLabel.text
    property alias name : nameLabel.text
    property alias date : dateLabel.text
    property alias place : placeLabel.text
    property alias price : priceLabel.text
    property alias ticket : ticketLabel.text
    property alias type : typeLabel.text
    property alias artist: artistLabel.text
    property alias genre: genreLabel.text
    property alias first_dancer: firstDancerLabel.text
    property alias number_dancers: numberDancersLabel.text
    property alias director: directorLabel.text

    RowLayout {
        Label {
            text: "code:"
        }

        Label {
            id: codeLabel
        }
    }
    RowLayout {
        Label {
            text: "name:"
        }

        Label {
            id: nameLabel
        }
    }
    RowLayout {
        Label {
            text: "date:"
        }

        Label {
            id: dateLabel
        }
    }
    RowLayout {
        Label {
            text: "place:"
        }

        Label {
            id: placeLabel
        }
    }
    RowLayout {

        Label {
            text: "price:"
        }

        Label {
            id: priceLabel
        }

    }
    RowLayout {

        Label {
            text: "ticket:"
        }

        Label {
            id: ticketLabel
        }
    }

    RowLayout {
        Label {
            text: "type:"
        }
        Label {
            id: typeLabel
        }
    }


    RowLayout {
        visible: root.type === SqlEventModel.Concert
        Label {
            id: artLabel
            text: "artist:"
        }

        Label {
            id: artistLabel
        }
    }

    RowLayout {
        visible: root.type === SqlEventModel.Concert
        Label {
            id: genLabel
            text: "genre:"
        }

        Label {
            id: genreLabel
        }
    }

    RowLayout {
        visible: root.type === SqlEventModel.Ballet
        Label {
            id: firstDancLabel
            text: "first dancer:"
        }

        Label {
            id: firstDancerLabel
        }
    }

    RowLayout {
        visible: root.type === SqlEventModel.Ballet
        Label {
            id: numDancLabel
            text: "number of dancers:"
        }


        Label {
            id: numberDancersLabel
        }
    }

    RowLayout {
        visible: root.type === SqlEventModel.Show
        Label {
            id: dirLabel
            text: "director:"
        }


        Label {
            id: directorLabel
        }

    }


    RowLayout {
        Button {
            id: editButton
            text: "Edit"
            onClicked:loadPage.setSource("CUeventPage.qml", {"index": root.index, "code": root.code, "name": root.name, "date": root.date,
                                             "place": root.place, "price": root.price, "ticket": root.ticket, "type": root.type,
                                             "artist": root.artist, "genre": root.genre, "first_dancer": root.first_dancer,
                                             "number_dancers": root.number_dancers, "director": root.director
                                         });
        }

        Button {
            id: remove
            text: "Remove"
            onClicked: loadPage.setSource("removeItemPopup.qml", {"index": root.index});
        }
    }

}


