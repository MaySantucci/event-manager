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
    property int type
    property alias artist: artistLabel.text
    property alias genre: genreLabel.text
    property alias first_dancer: firstDancerLabel.text
    property alias number_dancers: numberDancersLabel.text
    property alias director: directorLabel.text


    signal edit(int code, string name, string date, string place, string price, string ticket, int type, string artist, string genre, string dancer,
                   string dancers, string director);
    signal remove(int index);

    EventTypeModel{
    id:typeModel
    }

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
            text: {
                var i = typeModel.find(root.type);
                return typeModel.get(i).text;
            }
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
            onClicked: {
                root.edit(root.code, root.name, root.date, root.place, root.price, root.ticket, root.type, root.artist,
                             root.genre, root.first_dancer, root.number_dancers, root.director);
            }
        }

        Button {
            id: remove
            text: "Remove"
            onClicked: root.remove(root.index);
        }
    }

}


