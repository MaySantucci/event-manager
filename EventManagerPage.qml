import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Page {
    id:root
    //Toolbar

    Loader {
        id: pageLoader
    }

    header:
        ToolBar {
            id: headerBar
            height: 40

            ToolButton {
                text: qsTr("Add")
                font.pixelSize: 18
                onClicked: console.log(text + " clicked.")
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
                       id:events
                       ListElement {
                           name: "Metallica"
                           date: "21/10/2019"
                           palce: "Roma"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           name: "Colorado"
                           date: "21/11/2019"
                           palce: "Roma"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           name: "Miao"
                           date: "21/10/2020"
                           palce: "Livorno"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
                           name: "Bau"
                           date: "21/10/2020"
                           palce: "Livorno"
                           price: "100"
                           ticket: "2000"
                       }
                       ListElement {
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
                       onClicked: console.log(text)
                   }

               }
           }


           Rectangle {
               border.color: 'teal'
               Layout.fillWidth: true
               Layout.fillHeight: true
               Layout.minimumWidth: 100

               Text {
                   anchors.centerIn: parent
                   text: "Handle event"
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

