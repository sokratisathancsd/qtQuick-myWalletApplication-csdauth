import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 2.3
import BackEnd 1.0
import QtQuick.Dialogs 1.3

Rectangle{
    property int change:1
    property double removeBalance2:myBackEnd.getBalance()
    property string itemsForHistory:""
    color:"lightSteelBlue"
    anchors.fill: parent
    Rectangle{
        visible:false
        id:myRectangle
        anchors.fill: parent
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
                if(change==1){
                text=""
                color="black"
                }
                change++
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
            removeBalance2=myBackEnd.getBalance()
            removeBalance2=myBackEnd.removeBalance(t.text.substring(7), removeBalance2)
            if(removeBalance2<0){
                t.color="red"
            }
            else{
                if(textEdit.text==="Type a fund description..."){
                    textEdit.text="No Description Added"
                }

                t.color="green"
                mainRect2.visible=true
                myRectangle.visible=false
                myBackEnd.writeBalance(removeBalance2)
                myWallet.b = myBackEnd.getBalanceQML()
                main:view.currentIndex=3
                myBackEnd.addToHistory(textEdit.text+"@"+t.text.substring(7)+"$"+"\n")
                change=1
                textEdit.text="Type a fund description..."
                textEdit.color="#aaa"
                t.text="Funds: "
            }
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
            myBackEnd.addToHistory("\n")
            change=1
            mainRect2.visible=true
            myRectangle.visible=false
            main:view.currentIndex=3
            change=1
            t.color="black"
            point.enabled=true;
            t.text="Funds: "
            textEdit.text="Type a funds description..."
            main:view.currentIndex= myRectangle.lastPage;
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
    }
    Rectangle{
        id:mainRect2
        width:parent.width/1.5
        height:parent.height/3
        anchors.centerIn: parent
        Rectangle{
            id:labelRect
            color:"lightSteelblue"
            anchors.top:mainRect2.top
            width:parent.width
            height:parent.height/2
            Label{
                id:myQLabel
                width:parent.width
                height:parent.height
                anchors.top: parent.top
                Text{
                    wrapMode:Text.Wrap
                    width:parent.width
                    height:parent.height
                    text:("Do you want to add other expenses?")
                    color:"black"
                    font{
                        bold:true
                        family:"Arial"
                        pixelSize: (parent.height+parent.width)/16
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

            }
        }
        Rectangle{
            color:"lightSteelBlue"
                width:parent.width
                height:parent.height/2
                anchors.top:labelRect.bottom
                Button{
                    onClicked:{
                        mainRect2.visible=false
                        myRectangle.visible=true

                    }

                    width:parent.width/2.5
                    height:parent.height/2
                    anchors.top:parent.top
                    anchors.topMargin: height/2
                    anchors.rightMargin: width/4.5
                    anchors.right:parent.right
                    id:yes
                    Text{
                        wrapMode:Text.Wrap
                        width:parent.width
                        height:parent.height
                        text:("Yes")
                        color:"green"
                        font{
                            bold:true
                            family:"Arial"
                            pixelSize: (parent.height+parent.width)/16
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Button{
                    onClicked:{
                        main:view.currentIndex=3
                        change=1
                        myBackEnd.addToHistory(itemsForHistory+"\n")
                        myWallet.b = myBackEnd.getBalanceQML()
                    }

                    width:parent.width/2.5
                    height:parent.height/2
                    anchors.top:parent.top
                    anchors.topMargin: height/2
                    anchors.leftMargin: width/4.5
                    anchors.left:parent.left
                    id:no
                    Text{
                        wrapMode:Text.Wrap
                        width:parent.width
                        height:parent.height
                        text:("No")
                        color:"red"
                        font{
                            bold:true
                            family:"Arial"
                            pixelSize: (parent.height+parent.width)/16
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
       }

   }
    BackEnd{
        id:myBackEnd
    }

}
