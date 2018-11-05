import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

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
                onClicked: loadPage.setSource("CUeventPage.qml", {"name": "", "date": "", "place": "", "price": "", "ticket": ""});
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
                       onClicked: loadPage.setSource("EventDetails.qml", {"index": index, "code": code, "name": name, "date": date, "place":place,
                                                         "price": price, "ticket": ticket, "type": type_event});
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



