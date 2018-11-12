import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import io.qt.example.eventsmanager 1.0
ColumnLayout {
    id: root
    property int index
    property int code: -1
    property string name
    property string date
    property string place
    property string price
    property string ticket
    property int type: 0
    property string artist
    property string genre
    property string first_dancer
    property string number_dancers
    property string director

    QtObject {

    }

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

        currentIndex:  model.get(root.type).type;

        onCurrentIndexChanged: {
            root.type = currentIndex;
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
        text: root.artist
    }
    TextField {
        id: genreField
        placeholderText: qsTr("genre")
        visible: false
        text: root.genre
    }
    TextField {
        id: firstDancerField
        placeholderText: qsTr("first dancer")
        visible: false
        text: root.first_dancer
    }
    TextField {
        id: numberDancersField
        placeholderText: qsTr("number dancers")
        visible: false
        text: root.number_dancers
    }
    TextField {
        id: directorField
        placeholderText: qsTr("director")
        visible: false
        text: root.director
    }
    RowLayout {
        Button {
            id: save
            text: "Save"
            onClicked: {
                if(nameField.text.trim().length > 0 && dateField.text.trim().length > 0 && placeField.text.trim().length > 0 &&
                   priceField.text.trim().length > 0 && ticketField.text.trim().length > 0) {
                    requiredField.visible = false;
                    requiredCombo.visible = false;
                    requiredName.visible = false;
                    requiredDate.visible = false;
                    requiredPlace.visible = false;
                    requiredPrice.visible = false;
                    requiredTicket.visible = false;
                    if(root.code < 0) {
                        root.code = myDb.addEvent(nameField.text.trim(), dateField.text.trim(), placeField.text.trim(),
                                                  priceField.text.trim(), ticketField.text.trim(), root.type, artistField.text.trim(),
                                                  genreField.text.trim(), firstDancerField.text.trim(), numberDancersField.text.trim(),
                                                  directorField.text.trim());
                    } else {
                        if(nameField.text.trim().length > 0 && dateField.text.trim().length > 0 && placeField.text.trim().length > 0 &&
                           priceField.text.trim().length > 0 && ticketField.text.trim().length > 0) {

                            myDb.updateEvent(root.index, root.code, nameField.text.trim(), dateField.text.trim(), placeField.text.trim(),
                                             priceField.text.trim(), ticketField.text.trim(), root.type, artistField.text.trim(),
                                             genreField.text.trim(), firstDancerField.text.trim(), numberDancersField.text.trim(),
                                             directorField.text.trim());
                        }
                    }

                    root.details(root.code, nameField.text.trim(), dateField.text.trim(), placeField.text.trim(),
                                 priceField.text.trim(), ticketField.text.trim(), root.type, artistField.text.trim(),
                                 genreField.text.trim(), firstDancerField.text.trim(), numberDancersField.text.trim(),
                                 directorField.text.trim());

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
                if(nameField.text.trim().length > 0 && dateField.text.trim().length > 0 && placeField.text.trim().length > 0 &&
                   priceField.text.trim().length > 0 && ticketField.text.trim().length > 0) {
                    root.details(root.code, root.name, root.date, root.place, root.price,
                                 root.ticket, root.type, root.artist, root.genre, root.first_dancer,
                                 root.number_dancers, root.director);
                } else {
                    root.cancel();
                }

            }
        }
    }
}



