import QtQuick 2.0


Rectangle {
    id: rectRoot
    visible: true
    width: 640
    height: 480

    property var item_list

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    ListView {
        id: listV_animal
        x: 432
        y: 257
        width: 200; height: 215

        model: myModel
        delegate: Text { text: "Animal: " + type + ", " + size }


    }

    ListView {
        id: listV_user
        x: 10
        y: 257
        width: 200; height: 215

        model: mySortModel
        delegate: Text { text: "User: " + name + ", " + realName }

        onCurrentItemChanged: {
            if (currentItem) {
                text_under.text = currentItem.text
            }

        }
        onCurrentIndexChanged: {
            if (currentIndex == -1) {
                text_under.text = ""
                text_under_index.text = ""
            }
            else {
                if(currentItem) {
                    text_under_index.text = currentItem.text + " con indice " + currentIndex.toString()
                }
            }
        }
    }


    TextInput {
        anchors.centerIn: parent
        text: "sono qui"
        onTextChanged: {
            if(text == "") {
                // listV_user.visible = false
                // listV_animal.visible = false
                // listV_user.currentIndex = -1
                myModel.setFilterRegExp("^"+text)
                mySortModel.setFilterRegExp("^"+text)
                if(listV_user.currentItem){
                    listV_user.currentIndex = 0
                }
            }
            else {
                listV_user.visible = true
                listV_animal.visible = true
                myModel.setFilterRegExp("^"+text)
                mySortModel.setFilterRegExp("^"+text)
                if(listV_user.currentItem){
                    listV_user.currentIndex = 0
                }
            }

        }

        Keys.onPressed: {
            console.log("TextInput inside SquareButton!")
            if(event.key == Qt.Key_Up) {
                event.accepted = true;
                listV_user.decrementCurrentIndex()
            }
            if(event.key == Qt.Key_Down) {
                event.accepted = true;
                listV_user.incrementCurrentIndex()
            }
            if(event.key == Qt.Key_Enter) {
//                console.log("move up or down");
                event.accepted = true;
            }
        }
        //onTextChanged: qmodel.setFilterFixedString(text)
    }

    Text {
        id: text_under
        x: 200
        y: 100
        // text: mySortModel.data(0,Qt::UserRole+1)
        // text: mySortModel.lastUser
        // text: "mySortModel.data()"
    }

    Text {
        id: text_under_index
        x: 200
        y: 150
        // text: mySortModel.data(0,Qt::UserRole+1)
        // text: mySortModel.lastUser
        // text: "mySortModel.data()"
    }
}
