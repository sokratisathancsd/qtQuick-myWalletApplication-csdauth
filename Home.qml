import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 2.3
import BackEnd 1.0

Rectangle{
    color:"LightSteelBlue"
    anchors.fill:parent
    Button {
        id:wallet
        width:parent.width/3
        height:parent.height/4
        x:parent.width/3
        y:parent.height/8
        onClicked:{
            main:view.currentIndex=3
        }

        Image{
            source:"img/wallet.png"
            anchors.fill:parent
        }

    }
    Rectangle{
        color:"LightSteelBlue"
        anchors.bottom:wallet.top
        anchors.left:wallet.left
        width:wallet.width
        height:wallet.height/6
        Text{
            width:parent.width
            height:parent.height
            //anchors.centerIn: parent
            text:qsTr("My Wallet")
            color:"green"
            font{
                bold:true
                family:"Arial"
                pixelSize: parent.width/8
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }
    Button{
        id:options
        width:parent.width/2
        height:parent.height/15
        x:parent.width/4
        y:parent.height/2
        onClicked:{
            main:view.currentIndex=1
        }

        Text{
            width:parent.width
            height:parent.height
            text:qsTr("Options")
            color:"black"
            font{
                bold:true
                family:"Arial"
                pixelSize: (parent.height+parent.width)/12
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

    Button{
        id:exit
        width:parent.width/2
        height:parent.height/15
        y:options.y+1.5*options.height
        x:parent.width/4
        topPadding: 12
        onClicked: {
            mainWindow.close()
        }

        Text{
            width:parent.width
            height:parent.height
            text:qsTr("Exit")
            color:"black"
            font{
                bold:true
                family:"Arial"
                pixelSize:(parent.height+parent.width)/12
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

}

