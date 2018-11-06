import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import io.qt.example.eventsmanager 1.0
ColumnLayout {
    id: root
    property int index
    property int code: -1
    property alias name: nameField.text
    property alias date : dateField.text
    property alias place : placeField.text
    property alias price : priceField.text
    property alias ticket : ticketField.text
    property string type
    property alias artist: artistField.text
    property alias genre: genreField.text
    property alias first_dancer: firstDancerField.text
    property alias number_dancers: numberDancersField.text
    property alias director: directorField.text

    Label {
        id: codeField
        text: root.code
        visible: root.code > 0
    }

    RowLayout {
        Label {
            id: requiredName
            text: "*"
            color: "red"
            visible: false
        }

        TextField {
            id: nameField
            placeholderText: qsTr("name")
        }
    }

    RowLayout {
        Label {
            id: requiredDate
            text: "*"
            color: "red"
            visible: false
        }

        TextField {
            id: dateField
            placeholderText: qsTr("date")
        }
    }

    RowLayout {
        Label {
            id: requiredPlace
            text: "*"
            color: "red"
            visible: false
        }

        TextField {
            id: placeField
            placeholderText: qsTr("place")
        }
    }

    RowLayout {
        Label {
            id: requiredPrice
            text: "*"
            color: "red"
            visible: false
        }

        TextField {
            id: priceField
            placeholderText: qsTr("price")
        }

    }

    RowLayout {
        Label {
            id: requiredTicket
            text: "*"
            color: "red"
            visible: false
        }

        TextField {
            id: ticketField
            placeholderText: qsTr("available ticket")
        }

    }
RowLayout {
    Label {
        id: requiredCombo
        text: "*"
        color: "red"
        visible: false
    }

    ComboBox {
        id: typeCombo
        model: ["Concert", "Show", "Ballet"]
        onActivated: {
            root.type = currentText;
            if(root.type === "Concert"){
                artistField.visible = true;
                genreField.visible = true;

                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = false;

                root.first_dancer = "";
                root.number_dancers = "";
                root.director = "";

            } else if (root.type === "Show") {

                directorField.visible = true;

                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = false;
                numberDancersField.visible = false;

                root.artist = "";
                root.genre = "";
                root.first_dancer = "";
                root.number_dancers = "";

            } else if (root.type === "Ballet") {

                firstDancerField.visible = true;
                numberDancersField.visible = true;

                artistField.visible = false;
                genreField.visible = false;
                directorField.visible = false;

                root.artist = "";
                root.genre = "";
                root.director = "";
            }
        }
        Component.onCompleted: {
            currentIndex = find(root.type);
            if(root.type === "Concert"){
                artistField.visible = true;
                genreField.visible = true;

                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = false;

                root.first_dancer = "";
                root.number_dancers = "";
                root.director = "";

            } else if (root.type === "Show") {

                directorField.visible = true;

                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = false;
                numberDancersField.visible = false;

                root.artist = "";
                root.genre = "";
                root.first_dancer = "";
                root.number_dancers = "";

            } else if (root.type === "Ballet") {

                firstDancerField.visible = true;
                numberDancersField.visible = true;

                artistField.visible = false;
                genreField.visible = false;
                directorField.visible = false;

                root.artist = "";
                root.genre = "";
                root.director = "";
            }
        }
    }    
}
    Label {
        id: requiredField
        text: "Required fields!"
        color: "red"
        visible: false;
    }

    TextField {
        id: artistField
        placeholderText: qsTr("artist")
        visible: false
    }
    TextField {
        id: genreField
        placeholderText: qsTr("genre")
        visible: false
    }
    TextField {
        id: firstDancerField
        placeholderText: qsTr("first dancer")
        visible: false
    }
    TextField {
        id: numberDancersField
        placeholderText: qsTr("number dancers")
        visible: false
    }
    TextField {
        id: directorField
        placeholderText: qsTr("director")
        visible: false
    }
    RowLayout {
        Button {
            id: save
            text: "Save"
            onClicked: {
                if(root.name.trim() != "" && root.date.trim() != "" && root.place.trim() != "" && root.price.trim() != "" && root.ticket.trim() != ""
                        && root.type.trim() != "") {
                    requiredField.visible = false;
                    requiredCombo.visible = false;
                    requiredName.visible = false;
                    requiredDate.visible = false;
                    requiredPlace.visible = false;
                    requiredPrice.visible = false;
                    requiredTicket.visible = false;
                    if(root.code < 0) {
                       root.code = myDb.addEvent( root.name, root.date, root.place, root.price,
                                       root.ticket, root.type, root.artist, root.genre, root.first_dancer,
                                       root.number_dancers, root.director);

                    } else {
                        myDb.updateEvent(root.index, root.code, root.name, root.date, root.place, root.price,
                                         root.ticket, root.type, root.artist, root.genre, root.first_dancer,
                                         root.number_dancers, root.director);
                    }

                    loadPage.setSource("EventDetails.qml", {"code": root.code, "name": root.name, "date": root.date, "place": root.place, "price": root.price,
                                                            "ticket": root.ticket, "type": root.type, "artist": root.artist, "genre": root.genre,
                                                            "first_dancer": root.first_dancer, "number_dancers": root.number_dancers,
                                                            "director": root.director});
                } else {
                    requiredField.visible = true;
                    requiredCombo.visible = true;
                    requiredName.visible = true;
                    requiredDate.visible = true;
                    requiredPlace.visible = true;
                    requiredPrice.visible = true;
                    requiredTicket.visible = true;
                    nameField.color = "red";
                    dateField.color = "red";
                    placeField.color = "red";
                    priceField.color = "red";
                    ticketField.color = "red";
                }
            }
        }
        Button {
            id: undo
            text: "Cancel"
            onClicked: {
                loadPage.setSource("EventDetails.qml");
            }
        }
    }
}



