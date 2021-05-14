import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 2.3
import BackEnd 1.0
import QtQuick.Dialogs 1.3


Rectangle{
    id:myRectangle
    anchors.fill: parent
    //property int lastPage: parent.lastPage
    color:"lightSteelBlue"
    Rectangle{
        id:funds
        color:"white"
        width:parent.width/4
        height:parent.height/15
        x:parent.width/2.75
        y:parent.height/10
        Text{
            wrapMode: Text.Wrap
            //clip: true
            id:t
            width:parent.width
            height:parent.height
            text:qsTr("Funds: ")
            color:"Black"
            font{
                bold:true
                family:"Arial"
                pixelSize: (parent.height+parent.width)/12
            }
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: note
        visible:false //den xrisimopoioume pouthena auto to description!
        width: parent.width/1.5
        height: parent.height/6
        x:parent.width/6
        anchors.top: funds.bottom
        anchors.topMargin: 12
        TextEdit {
            clip:true
            id:textEdit
            color:"#aaa"
            text: "Type a fund description..."
            wrapMode: TextEdit.Wrap
            anchors.fill: parent
            onFocusChanged: {
                text=""
                color="black"
            }
        }
    }

    Rectangle{
        id:calculator
        width:parent.width*2/3
        height:parent.height/1.85
        anchors.top: note.bottom
        x: parent.width/6
        //y:parent.height/4
        color:"LightSteelBlue"
        GridLayout{
           width: parent.width
           height: parent.height
           anchors.centerIn: parent
           rows:3
           columns:3
           rowSpacing: -10
           columnSpacing: 10
           Repeater{
               id:repeater
               model:9
               Button{
                   text:((1+(index%3)  )+  (2-Math.floor(index/3))*3)
                   Layout.fillWidth: true
                   onClicked: {
                      if(t.text.length<14){
                           t.text = t.text + text
                      }
                   }
               }
           }
           Button{
               Layout.fillWidth: true
               Text{
                   id:erase
                   text:"Erase"
                   anchors.centerIn: parent
                   font{
                       bold:true
                       pixelSize:(parent.height+parent.width)/12
                   }

               }
               onClicked: {
                   t.color="black"
                  point.enabled=true
                  t.text="Funds: "
               }
           }

           Button{
               Layout.fillWidth: true
               Text{
                   id:text0
                   text:"0"
                   anchors.centerIn: parent
               }
               onClicked: {
                  if(t.text.length<14)
                   t.text = t.text + text0.text
               }
           }
           Button{
               id:point
               Layout.fillWidth:true
               Text{
                   id:textpoint
                   text:"."
                   anchors.centerIn: parent
                   font{
                       bold:true
                       pixelSize:(parent.height+parent.width)/12
                   }
               }
               onClicked:{
                   if(t.text.length<14){
                       point.enabled=false
                       t.text=t.text+textpoint.text
                   }

               }
           }
        }
    }

    Button {
        id:confirm
        width:parent.width/4
        height:parent.height/12
        x:parent.width/3 + parent.width/4
        anchors.top: calculator.bottom
        onClicked: {
            myBackEnd.addBalance(t.text.substring(7))
            t.text="Funds: "
            addFundsCalc.visible=false
            myWalletMenu.visible=true
            myWallet.b = myBackEnd.getBalance()
            /*var flag=true;
            point.enabled=true;
            if(lastPage !== 4){
            myBackEnd.addBalance(t.text.substring(7))
            }
            else{
                flag=myBackEnd.removeBalance((t.text.substring(7)))
                }
             if(flag){
                main:view:myWallet.b = myBackEnd.getBalance();
                t.text="Funds: "
                main:view.currentIndex= myRectangle.lastPage;
                t.color="black"
            }
             else{
                 t.color="red"
             }*/
        }


        Text{
             text:qsTr("Confirm")
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

    Button {
        id:cancel
        width:parent.width/4
        height:parent.height/12
        x:parent.width/6
        anchors.top: calculator.bottom
        onClicked: {
            t.text="Funds: "
            addFundsCalc.visible=false
            myWalletMenu.visible=true
            point.enabled=true;
        }

        Text{
             text:qsTr("Cancel")
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
    BackEnd{
        id:myBackEnd
    }

}
