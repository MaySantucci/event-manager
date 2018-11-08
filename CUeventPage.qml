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
    property int type: -1
    property alias artist: artistField.text
    property alias genre: genreField.text
    property alias first_dancer: firstDancerField.text
    property alias number_dancers: numberDancersField.text
    property alias director: directorField.text


    signal cancel();
    signal details(int code, string name, string date, string place, string price, string ticket, int type, string artist, string genre, string dancer,
                   string dancers, string director);

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
            text: root.name
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
            text: root.date
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
            text: root.place
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
            text: root.price
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
            text: root.ticket
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
        textRole: "text"
        model: EventTypeModel{
            id: typeModel
        }
        onActivated: {
            root.type = model.get(currentIndex).type;
            if(root.type === SqlEventModel.Concert){
                artistField.visible = true;
                genreField.visible = true;

                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = false;

                root.first_dancer = "";
                root.number_dancers = "";
                root.director = "";

            } else if (root.type === SqlEventModel.Show) {

                directorField.visible = true;

                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = false;
                numberDancersField.visible = false;

                root.artist = "";
                root.genre = "";
                root.first_dancer = "";
                root.number_dancers = "";

            } else if (root.type === SqlEventModel.Ballet) {

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
            if(root.type === -1) {
                currentIndex = 0;
            } else {
                currentIndex = typeModel.find(root.type);
            }

            activated(currentIndex);
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
        text: root.artist
        visible: false
    }
    TextField {
        id: genreField
        placeholderText: qsTr("genre")
        text: root.genre
        visible: false
    }
    TextField {
        id: firstDancerField
        placeholderText: qsTr("first dancer")
        text: root.first_dancer
        visible: false
    }
    TextField {
        id: numberDancersField
        placeholderText: qsTr("number dancers")
        text: root.number_dancers
        visible: false
    }
    TextField {
        id: directorField
        placeholderText: qsTr("director")
        text: root.director
        visible: false
    }
    RowLayout {
        Button {
            id: save
            text: "Save"
            onClicked: {
                if(root.name.trim() !== "" && root.date.trim() !== "" && root.place.trim() !== "" && root.price.trim() !== ""
                        && root.ticket.trim() !== "") {
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
                        console.log(root.code);

                    } else {
                        myDb.updateEvent(root.index, root.code, root.name, root.date, root.place, root.price,
                                         root.ticket, root.type, root.artist, root.genre, root.first_dancer,
                                         root.number_dancers, root.director);
                    }

                    console.log("Update done.");

                    root.details(root.code, root.name, root.date, root.place, root.price, root.ticket, root.type, root.artist,
                                 root.genre, root.first_dancer, root.number_dancers, root.director);

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
                    console.log("Cancel: field empty");
                    root.cancel();
                }
            }
    }
}



