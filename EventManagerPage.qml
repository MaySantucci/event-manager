import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQml 2.11

import io.qt.example.eventsmanager 1.0

Page {
    id: root

    property int selectedEventIndex: -1

    //Toolbar
    header: ToolBar {
        id: headerBar
        height: 40

        ToolButton {
            text: qsTr("Add")
            font.pixelSize: 18
            onClicked: {
                loadPage.sourceComponent = cuEventComponent;
                loadPage.item.code = -1;
                loadPage.item.name = "";
                loadPage.item.date = "";
                loadPage.item.place = "";
                loadPage.item.price = "";
                loadPage.item.ticket = "";
                loadPage.item.type = 0;
                loadPage.item.artist = "";
                loadPage.item.genre = "";
                loadPage.item.first_dancer = "";
                loadPage.item.number_dancers = "";
                loadPage.item.director = "";
            }
        }

        Label {
            id: headerLabel
            anchors.centerIn: parent
            text: "Events Manager"
            font.pixelSize: 20
        }
    }

    //Event section
    RowLayout {
        id: eventSection
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Rectangle {
            border.color: 'teal'
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 50

            ListView {
                id: listEvents
                anchors.fill: parent
                topMargin: 10
                leftMargin: 10
                bottomMargin: 10
                rightMargin: 10
                spacing: 10
                clip: true

                model: myDb

                delegate: ItemDelegate {
                    text: model.name
                    width: listEvents.width - listEvents.leftMargin - listEvents.rightMargin
                    onClicked: {
                        root.selectedEventIndex = index;

                        loadPage.sourceComponent = eventDetailsComponent;

                        loadPage.item.code = code;
                        loadPage.item.name = name;
                        loadPage.item.date = date;
                        loadPage.item.place = place;
                        loadPage.item.price = price;
                        loadPage.item.ticket = ticket;
                        loadPage.item.type = type_event;
                        loadPage.item.artist = artist;
                        loadPage.item.genre = genre;
                        loadPage.item.first_dancer = first_dancer;
                        loadPage.item.number_dancers = number_dancers;
                        loadPage.item.director = director;
                    }
                }
            }
        }

        Rectangle {
            id: handleEvent
            border.color: 'teal'
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 100

            Loader {
                id: loadPage
                anchors.centerIn: parent
            }

            Component {
                id: cuEventComponent
                CUeventPage {
                    id: pageReal
                    onCancel: loadPage.sourceComponent = null;
                    onDetails: {
                        loadPage.sourceComponent = eventDetailsComponent;

                        loadPage.item.code = myDb.get(selectedEventIndex, SqlEventModel.CodeRole);
                        loadPage.item.name = myDb.get(selectedEventIndex, SqlEventModel.NameRole);
                        loadPage.item.date = myDb.get(selectedEventIndex, SqlEventModel.DateRole);
                        loadPage.item.place = myDb.get(selectedEventIndex, SqlEventModel.PlaceRole);
                        loadPage.item.price = myDb.get(selectedEventIndex, SqlEventModel.PriceRole);
                        loadPage.item.ticket = myDb.get(selectedEventIndex, SqlEventModel.TicketRole);
                        loadPage.item.type = myDb.get(selectedEventIndex, SqlEventModel.TypeEventRole);
                        loadPage.item.artist = myDb.get(selectedEventIndex, SqlEventModel.ArtistRole);
                        loadPage.item.genre = myDb.get(selectedEventIndex, SqlEventModel.GenreRole);
                        loadPage.item.first_dancer = myDb.get(selectedEventIndex, SqlEventModel.FirstDancerRole);
                        loadPage.item.number_dancers = myDb.get(selectedEventIndex, SqlEventModel.NumberDancersRole);
                        loadPage.item.director = myDb.get(selectedEventIndex, SqlEventModel.DirectorRole);

                    }
                }
            }

            Component {
                id: eventDetailsComponent
                EventDetails {
                    id: detailsPageReal
                    onEdit: {
                        loadPage.sourceComponent = cuEventComponent;
                        loadPage.item.code = myDb.get(selectedEventIndex, SqlEventModel.CodeRole);
                        loadPage.item.name = myDb.get(selectedEventIndex, SqlEventModel.NameRole);
                        loadPage.item.date = myDb.get(selectedEventIndex, SqlEventModel.DateRole);
                        loadPage.item.place = myDb.get(selectedEventIndex, SqlEventModel.PlaceRole);
                        loadPage.item.price = myDb.get(selectedEventIndex, SqlEventModel.PriceRole);
                        loadPage.item.ticket = myDb.get(selectedEventIndex, SqlEventModel.TicketRole);
                        loadPage.item.type = myDb.get(selectedEventIndex, SqlEventModel.TypeEventRole);
                        loadPage.item.artist = myDb.get(selectedEventIndex, SqlEventModel.ArtistRole);
                        loadPage.item.genre = myDb.get(selectedEventIndex, SqlEventModel.GenreRole);
                        loadPage.item.first_dancer = myDb.get(selectedEventIndex, SqlEventModel.FirstDancerRole);
                        loadPage.item.number_dancers = myDb.get(selectedEventIndex, SqlEventModel.NumberDancersRole);
                        loadPage.item.director = myDb.get(selectedEventIndex, SqlEventModel.DirectorRole);
                    }
                    onRemove: {
                        loadPage.source = "RemoveItemPopup.qml";
                        loadPage.item.index = selectedEventIndex;
                    }
                }
            }
        }
    }

    //footer
    footer: Pane {
        background: Rectangle {
            color: "#eeeeee"
        }

        Label {
            anchors.centerIn: parent
            text: qsTr("@event-manager")
        }
    }
}
