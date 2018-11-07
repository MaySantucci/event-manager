import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQml 2.11

import io.qt.example.eventsmanager 1.0

Page {
    id:root
    //Toolbar

    header:
        ToolBar {
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
                    loadPage.item.artist = "";
                    loadPage.item.genre = "";
                    loadPage.item.first_dancer= "";
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
        id:eventSection
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
                           loadPage.sourceComponent = eventDetailsComponent;
                           loadPage.item.index = index;
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
                       name: name
                        onCancel: loadPage.sourceComponent = null;
                   }
               }

               Component {
                   id: eventDetailsComponent
                   EventDetails {
                       id: detailsPageReal
                   }
               }
           }
    }


    //footer

    footer:
        Pane {
            background: Rectangle {
                color: "#eeeeee"
            }

            Label {
                anchors.centerIn: parent
                text: qsTr("@event-manager")
            }
        }
}



