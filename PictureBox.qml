import QtQuick 2.0

Rectangle {
    id: wrapper
    width: 200
    height: contactInfo.height*2
    color: ListView.isCurrentItem ? "black" : "red"
    property string prova_name: ListView.isCurrentItem ? contactInfo.text : ""
    property alias prova_password: password_text.text
    property string model_name: password_text.text

    Text {
        y: 0
        id: contactInfo
        text: model_name

        color: wrapper.ListView.isCurrentItem ? "red" : "black"
    }
    TextInput {
        y:10
        width: 200
        id: password_text
        text: "listV_user password"
        color: wrapper.ListView.isCurrentItem ? "red" : "black"
    }
}
