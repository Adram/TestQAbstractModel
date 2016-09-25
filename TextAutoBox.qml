import QtQuick 2.0

FocusScope {
    id: root
    property string textUserValue
    property string textUserPassword
    property bool indice_cambiato: false
    property bool text_name_cambiato_da_text: false

    //PictureBox {
    //    id: pictureDelegate
    //    model_name: listV_user.model.name
    //}

    Component {
        id: contactsDelegateT

        Rectangle {
            id: wrapper
            width: 200
            height: contactInfo.height*2
            color: ListView.isCurrentItem ? "black" : "red"
            property string prova_name: ListView.isCurrentItem ? contactInfo.text : ""
            property alias testo_input_cam: password_text.testo_input_cambiato
            property bool mouse_click
            Text {
                y: 0
                id: contactInfo
                text: name

                color: wrapper.ListView.isCurrentItem ? "red" : "black"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("MouseArea - indice: "+index)
                    listV_user.currentIndex = index
                    // item.DelegateModel.inSelected = !item.DelegateModel.inSelected
                    //password_text.focus = true
                    //password_text.enabled = true
                    //scope.focus = true
                    wrapper.mouse_click = true
                    text_name_cambiato_da_text = true
                    text_name.text = text_under.text
                }
            }
            FocusScope {
                id: scope


                focus: false
                onFocusChanged: {
                    console.log("FocusScope - FocusChanged! - Current: "+listV_user.currentIndex+" Select: "+index)
                }

                onActiveFocusChanged: {
                    console.log("FocusScope - ActiveFocusChaged!! - Current: "+listV_user.currentIndex+" Select: "+index)
                }

                TextInput {
                    y:10
                    width: 200
                    id: password_text
                    focus: true
                    text: "listV_user password"
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    property bool testo_input_cambiato: false
                    onTextChanged: {
                        textUserPassword = text
                    }

                    onFocusChanged: {
                        console.log("TextInput! - FocusChanged! - Current: "+listV_user.currentIndex+" Select: "+index)
                    }

                    onActiveFocusOnPressChanged: {
                        console.log("TextInput - ActiveFocusOnPressChanged! - Current: "+listV_user.currentIndex+" Select: "+index)
                    }

                    onActiveFocusChanged: {
                        console.log("TextInput - ActiveFocusChanged! - Current: "+listV_user.currentIndex+" Select: "+index)
                        console.log("TextInput - ActiveFocusChanged! - ActiveFocus: "+activeFocus)
                        if(activeFocus) {

                            indice_cambiato = true
                            listV_user.currentIndex = index
                            console.log("TextInput - ActiveFocusChanged! - After Index Changed ActiveFocus: "+activeFocus)
                            forceActiveFocus()
                            text_name_cambiato_da_text = true
                            text_name.text = text_under.text
                        }
                    }

                    Keys.onPressed: {
                        if((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return)) {
                            console.log("Dentro il ListView! - Premuto tasto Enter / Return")
                            // event.accepted = true;
                            // prova_password = text
                            // textUserPassword = text
                        }
                    }
                }
            }
        }
    }

    ListView {
        id: listV_user
        //anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        width: 300; height: 100



        model: mySortModel
        //delegate: Text { text: name}
        //delegate: pictureDelegate
        delegate: contactsDelegateT


        onCurrentItemChanged: {
            if (currentItem) {
                text_under.text = currentItem.prova_name
                currentItem.testo_input_cam = true
                // errore currentItem.password_text.testo_input_cambiato = true
            }
        }
        onCurrentIndexChanged: {
            console.log("ListView - CurrentIndexChanged! - Current: "+currentIndex+" ActiveFocus: "+activeFocus)
            if (currentIndex == -1) {
                text_under.text = ""
                // text_under_index.text = ""
            }
            else {
                console.log("ListView - CurrentIndexChanged! - Before Current: "+currentIndex)

                if(text_name.testo_cambiato) {
                    text_name.testo_cambiato = false
                    currentIndex = 0
                }
                console.log("ListView - CurrentIndexChanged! - After Current: "+currentIndex)
            }
            if (indice_cambiato) {
                console.log("ListView - CurrentIndexChanged! - Cambiato da TextInput")
                indice_cambiato = false
            }

        }
    }


    Text {
        id: text_under

        y: 240
        width: 200
        height: 20
        color: "#c7c1c1"
        clip: true

        text: "inserisci il nome utente"
    }

    TextInput {
        id: text_name

        y: 240
        width: 200
        height: 20
        clip: true
        //text: qsTr("Sono qui!!")
        //inputMask: qsTr("")
        //passwordCharacter: "•"
        //font.pixelSize: 12

        property bool testo_cambiato: false


        focus: true

        onTesto_cambiatoChanged: {
            console.log("testo_cambiato è stato cambiato! Indice: " + listV_user.currentIndex.toString())

        }

        onTextChanged: {
            console.log("Testo cambiato!")
            //myModel.setFilterRegExp("^"+text)
            if(!text_name_cambiato_da_text) {

                mySortModel.setFilterRegExp("^"+text)
                testo_cambiato = true
            }
            else {
                text_name_cambiato_da_text = false
            }


            textUserValue = text


            if(text == "") {
                if(listV_user.currentItem)
                {
                    console.log("Testo cambiato - indice a: " + listV_user.currentIndex.toString())
                    console.log("Testo cambiato - a nullo!")
                }
            }
            else {
                if(listV_user.currentItem)
                {
                    console.log("Testo cambiato - indice a: " + listV_user.currentIndex.toString())
                    console.log("Testo cambiato - a: " + text)
                }
            }
        }

        Keys.onPressed: {
            console.log("Tasto premuto")
            testo_cambiato = false
            if(event.key == Qt.Key_Right) {
                console.log("Tasto destro")

                if ((listV_user.currentIndex != -1) &&
                    (((text != text_under.text) && (text != "")) ||
                     (text == "")
                    )
                   ) {
                    event.accepted = true;
                    text = text_under.text
                }
            }
            if(event.key == Qt.Key_Up) {
                console.log("Tasto su")
                event.accepted = true;
                listV_user.decrementCurrentIndex()
            }
            if(event.key == Qt.Key_Down) {
                console.log("Tasto giù")
                event.accepted = true;
                listV_user.incrementCurrentIndex()
                console.log("Tasto giù - after")
            }
            if((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return)) {
                console.log("Tasto Enter / Return")
                // event.accepted = true;
            }
        }
    }
}
