import QtQuick 2.0


Rectangle {
    id: rectRoot
    visible: true
    width: 640
    height: 480

    //LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    //LayoutMirroring.childrenInherit: true


//    ListView {
//      id: listV_animal
//      x: 432
//      y: 257
//      width: 200; height: 215

//      model: myModel
//      delegate: Text { text: "Animal: " + type + ", " + size }


    //  }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle{
            x: 0; y: 0; width: 200; height: 228; color: "yellow"

            MouseArea {
                id: mouseArea1
                x: 15
                y: 109
                width: 100
                height: 100
                onClicked: {
                    console.log("Click del mouse - x="+mouseX.toString()+" e y="+mouseY.toString())
                }

            }

            FocusScope {
                id: focusScope1
                x: 15
                y: 8
                width: 100
                height: 100

            }

        }

        Image {
            id: rectangle
            anchors.centerIn: parent
            //width: Math.max(320, mainColumn.implicitWidth)
            //height: Math.max(320, mainColumn.implicitHeight)


            Column {
                id: mainColumn
                anchors.centerIn: parent

                //spacing: 12


                TextInput {
                    id: text_generic
                    x: 0
                    y: 0

                    width: 200
                    height: 20
                    clip: true

                    text: "generic text"
                    KeyNavigation.backtab: text_pswd; KeyNavigation.tab: text_user_name
                    }

                Column {
                    width: parent.width
                    height: 350   // , mainColumn.implicitHeight + 350)
                    //spacing: 4

                    TextAutoBox {
                    //TextInput {

                        id: text_user_name
                        KeyNavigation.backtab: text_generic; KeyNavigation.tab: text_pswd
                        height: parent.height

                        //text: "User Text"
                        Keys.onEnterPressed: {
                            //text_generic.text = textUserValue
                        }

                        Keys.onReturnPressed: {
                            text_generic.text = textUserValue
                            text_pswd.text = textUserPassword
                        }

                    }
                }

                TextInput {
                    id: text_pswd
                    x: 0
                    y: 30

                    width: 200
                    height: 20
                    clip: true

                    text: "password text"

                    KeyNavigation.backtab: text_user_name; KeyNavigation.tab: text_generic
                }
            }
        }
    }
}
