import QtQuick 2.0
import io.qt.example.eventsmanager 1.0

ListModel {
    function find(type) {
        for(var i = 0; i < count; i++) {
            if(type === get(i).type){
                return i;
            }
        }
    }

    ListElement {
        type: SqlEventModel.Concert
        text: "Concert"
    }
    ListElement {
        type: SqlEventModel.Show
        text: "Show"
    }
    ListElement {
        type: SqlEventModel.Ballet
        text: "Ballet"
    }

}
