import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import io.qt.example.eventsmanager 1.0
ColumnLayout {
    id: root
    property int index
    property alias code: codeField.text
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
        text: qsTr("code")
    }
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
        id: typeCombo
        model: ["Concert", "Show", "Ballet"]
        onActivated: {
            type = currentText;
            if(type == "Concert"){
                artistField.visible = true;
                genreField.visible = true;
                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = false;
            } else if (type == "Show") {
                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = true;
            } else if (type == "Ballet") {
                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = true;
                numberDancersField.visible = true;
                directorField.visible = false;
            }
        }
        Component.onCompleted: {
            currentIndex = find(type);
            if(type == "Concert"){
                artistField.visible = true;
                genreField.visible = true;
                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = false;
            } else if (type == "Show") {
                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = false;
                numberDancersField.visible = false;
                directorField.visible = true;
            } else if (type == "Ballet") {
                artistField.visible = false;
                genreField.visible = false;
                firstDancerField.visible = true;
                numberDancersField.visible = true;
                directorField.visible = false;
            }
        }
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
                myDb.saveEvent(root.index, root.code, root.name, root.date, root.place, root.price,
                               root.ticket, root.type, root.artist, root.genre, root.first_dancer,
                               root.number_dancers, root.director);
                loadPage.setSource("EventDetails.qml", {"code": code, "name": name, "date": date, "place":place, "price": price,
                                                        "ticket": ticket, "type": type, "artist": artist, "genre": genre,
                                                        "first_dancer": first_dancer, "number_dancers": number_dancers,
                                                        "director": director});
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



