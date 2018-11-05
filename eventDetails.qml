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
    property alias artist: artistLabel.text
    property alias genre: genreLabel.text
    property alias first_dancer: firstDancerLabel.text
    property alias number_dancers: numberDancersLabel.text
    property alias director: directorLabel.text


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

    Label {
        id: artistLabel
        Component.onCompleted: {
            if(artist == "") {
                artistLabel.visible = false;
            }
        }
    }
    Label {
        id: genreLabel
        Component.onCompleted: {
            if(genre == "") {
                genreLabel.visible = false;
            }

        }
    }
    Label {
        id: firstDancerLabel
        Component.onCompleted: {
            if(first_dancer == "") {
                firstDancerLabel.visible = false;
            }

        }
    }
    Label {
        id: numberDancersLabel
        Component.onCompleted: {
            if(number_dancers == "") {
                numberDancersLabel.visible = false;
            }

        }
    }
    Label {
        id: directorLabel
        Component.onCompleted: {
            if(director == "") {
                directorLabel.visible = false;
            }

        }
    }

    RowLayout {
        Button {
            id: editButton
            text: "Edit"
            onClicked:loadPage.setSource("CUeventPage.qml", {"index": index, "code": code, "name": name, "date": date, "place":place, "price": price,
                                             "ticket": ticket, "type": type, "artist": artist, "genre": genre, "first_dancer": first_dancer,
                                             "number_dancers": number_dancers, "director": director
                                         });
        }

        Button {
            id: remove
            text: "Remove"
            onClicked: loadPage.setSource("removeItemPopup.qml", {"index": index});
        }
    }

}


