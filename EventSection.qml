import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

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
            
            model: ["Metallica", "Conca Rock", "Brignano", "Romeo e Giulietta", "Colorado", "Il lago dei cigni"]
            delegate: ItemDelegate {
                text:  modelData
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
