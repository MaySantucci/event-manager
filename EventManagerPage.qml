import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

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
                onClicked: loadPage.source = "CRUeventPage.qml"
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

                   model: ListModel {
                       ListElement {
                           id_elem: 0
                           name: "Metallica"
                           date: "21/10/2019"
                           palce: "Roma"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           id_elem: 1
                           name: "Colorado"
                           date: "21/11/2019"
                           palce: "Roma"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           id_elem: 2
                           name: "Miao"
                           date: "21/10/2020"
                           palce: "Livorno"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           id_elem: 3
                           name: "Bau"
                           date: "21/10/2020"
                           palce: "Livorno"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           id_elem: 4
                           name: "Cra Cra"
                           date: "21/10/2020"
                           palce: "Livorno"
                           price: "100"
                           ticket: "2000"
                       }
                   }

                   delegate: ItemDelegate {
                       text:  name
                       width: listEvents.width - listEvents.leftMargin - listEvents.rightMargin
                       onClicked: loadPage.setSource("EventDetails.qml");
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



