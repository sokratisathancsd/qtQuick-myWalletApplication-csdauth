import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 2.3
import BackEnd 1.0

Rectangle {
    Rectangle{
        id:addFundsCalc
        visible:false
        anchors.fill: parent
        AddFunds{

        }
    }
    id:wallet
    anchors.fill: parent
    color:"LightSteelBlue"
    property string b: parent.b
    Rectangle{
        color:"lightSteelBlue"
        id:myWalletMenu
        anchors.fill: parent
        visible:true
    Rectangle{
        id: balance
        color:parent.color
        width:parent.width/2
        height:parent.height/15
        x:parent.width/4
        y:parent.height/10


        Text{
            id:balanceText
            width:parent.width
            height:parent.height
            text:("My Balance: "+wallet.b)
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

        id:addfunds
        width:parent.width/3
        height:parent.height/12
        x:balance.x/2
        y:balance.y*3
        onClicked: {
            addFundsCalc.visible=true
            myWalletMenu.visible=false
        }

        Text{
            text:qsTr("Add Funds")
            color:"green"
            width:parent.width
            height:parent.height
            font{
                bold:true
                family:"Arial"
                pixelSize:(parent.height+parent.width)/12

            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Button{
        id:removefunds
        width:parent.width/3
        height:parent.height/12
        x:balance.x*2
        y:balance.y*3
        onClicked: {
            main:view.currentIndex=4
        }

        Text{
            text:qsTr("Remove Funds")
            color:"red"
            width:parent.width
            height:parent.height
            font{
                bold:true
                family:"Arial"
                pixelSize:(parent.height+parent.width)/12

            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Button{
        width:parent.width/7
        height:parent.width/7
        anchors.bottom:parent.bottom
        anchors.right:parent.right
        anchors.bottomMargin:height/2
        anchors.rightMargin:width/2
        Image{
            source:"img/menu.png"
            anchors.fill:parent
        }
        onClicked:{
            main:view.currentIndex=2;
        }

    }

}
    BackEnd{
        id:myBackEnd
    }
}
