import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 1.4 as Qtc1
import QtQuick.Controls 2.3

/*Rectangle {
    property string itemsForHistory:""
    anchors.fill: parent
    color:"LightSteelBlue"

    Button{
        id:chooseFunds
        onClicked:{
            main:view.currentIndex=5
        }

        width:parent.width/2
        height:parent.height/10
        x:parent.width/4
        y:parent.height/12
        Text{
            text:qsTr("Choose your own funds")
            width:parent.width
            height:parent.height
            font{
                bold:true
                family:"Arial"
                pixelSize:(parent.height+parent.width)/15

            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Button{
        onClicked:{
            items.visible=true
        }

        id:selectItems
        width:parent.width/2
        height:parent.height/10
        anchors.top:chooseFunds.bottom
        anchors.right:chooseFunds.right
        anchors.topMargin:height/2
        Text{
            text:qsTr("Select Items")
            width:parent.width
            height:parent.height
            font{
                bold:true
                family:"Arial"
                pixelSize:(parent.height+parent.width)/15

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
            source:"img/wallet.png"
            anchors.fill:parent
        }
        onClicked:{
            main:view.currentIndex=3;
        }

    }*/

Rectangle{
    property var categories:[]
    property var cost:[]
    property string itemsForHistory:""
    id:removeFundsMainRect
    property double removeBalance1: myBackEnd.getBalance()
    color:"lightsteelBlue"
    anchors.fill: parent
    Rectangle{
        id:mainRect
        width:parent.width/1.5
        height:parent.height/3
        anchors.centerIn: parent
        Rectangle{
            id:labelRect
            color:"lightSteelblue"
            anchors.top:mainRect.top
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
                    text:("Do you want to add from your Daily Items?")
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
                        mainRect.visible=false
                        items.visible=true
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
                        myBackEnd.addToHistory(Qt.formatDateTime(new Date(), "dd/MM/yy")+"#")
                        main:view.currentIndex=5
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




    Rectangle{
        property string itemsForHistory:""
        color:"lightSteelBlue"
        id:items
        visible:false
        anchors.fill:parent

        Rectangle{
           color:"lightsteelblue"
           id:fundstoremove
           width:parent.width
           height:parent.height/1.4*2/5
           ListView{
               clip: true
                id:myLV
                width:parent.width*3/5
                height:parent.height
                model:myLVmodel
                delegate: myDelegate
           }
           ListModel{
               id:myLVmodel
               ListElement{
                   name:""
               }
           }

          Component{
            id:myDelegate
            Item{
                id: myFundItem
                width:myLV.width
                height:myLV.height/10
                Label{
                    anchors.fill:parent
                    verticalAlignment:"AlignVCenter"
                    Text{
                        wrapMode:Text.Wrap
                        id:clearAll
                        width:parent.width
                        height:parent.height
                        text:name
                        color:"green"
                        font{
                            bold:true
                            family:"Arial"
                            pixelSize: (parent.height+parent.width)/24
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    //text:name
               }
            }
           }


            Label{
                id:labelCost
                property real totalcost:0
                Text{
                    wrapMode:Text.Wrap
                    id:totalCost
                    width:parent.width
                    height:parent.height
                    text:("Total Cost: ")
                    color:"black"
                    font{
                        bold:true
                        family:"Arial"
                        pixelSize: (parent.height+parent.width)/16
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                width:parent.width*2/5
                height:parent.height*3/5
                anchors.left:myLV.right
            }
            Button{
                width:parent.width*2/5
                height:parent.height*2/5
                anchors.top:labelCost.bottom
                anchors.left:myLV.right
                onClicked:{
                    myLVmodel.remove(0,myLVmodel.rowCount())
                    totalCost.text="Total Cost: "
                    labelCost.totalcost=0
                    totalCost.color="black"
                    itemsForHistory=""
                    removeFundsMainRect.categories=[]
                    removeFundsMainRect.cost=[]
                }

                Text{
                    wrapMode:Text.Wrap
                    id:clearAll
                    width:parent.width
                    height:parent.height
                    text:("Clear all")
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

        Qtc1.TableView {
            anchors.top:fundstoremove.bottom
                id: products
                width:parent.width
                height:parent.height/1.4*3/5
                    Qtc1.TableViewColumn {
                        role: "title"
                        title:"Title"
                        width: parent.width/2
                    }
                    Qtc1.TableViewColumn {
                        role: "cost"
                        title: "Cost"
                        width: parent.width/2
                    }
                   model: mediator.myModel
                   onClicked:{
                      myLVmodel.append({"name": mediator.getTitle(currentRow)})
                      itemsForHistory=itemsForHistory+mediator.getTitle(currentRow)+"@"+mediator.getCost(currentRow)+"$"
                      labelCost.totalcost+=mediator.getCost(currentRow)
                      totalCost.text="Total Cost: "+labelCost.totalcost
                      removeFundsMainRect.categories.push(mediator.getCategory(currentRow))
                      removeFundsMainRect.cost.push(mediator.getCost(currentRow))

                   }
        }

        /*Button{
            onClicked:{
                myLVmodel.remove(0,myLVmodel.rowCount())
                totalCost.text="Total Cost: "
                totalCost.color="black"
                labelCost.totalcost=0
                itemsForHistory=""
                items.visible=false
            }

            id:prodCancel
            y:(parent.height+products.height)/2
            x:parent.width/12
            width:parent.width/3
            height:parent.height/10
            Text{
                color:"red"
                text:qsTr("Cancel")
                width:parent.width
                height:parent.height
                font{
                    bold:true
                    family:"Arial"
                    pixelSize:(parent.height+parent.width)/15

                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }*/
        Button{
            onClicked:{
                removeBalance1=myBackEnd.getBalance()
                removeBalance1=myBackEnd.removeBalance(totalCost.text.substring(12), removeBalance1)
                if(removeBalance1<0){
                    removeBalance1= myBackEnd.getBalance()
                    totalCost.color="red"
                }
                else {
                    mainRect.visible=true
                    items.visible=false
                    myLVmodel.remove(0,myLVmodel.rowCount())
                    totalCost.text="Total Cost: "
                    myBackEnd.addToHistory(Qt.formatDateTime(new Date(), "dd/MM/yy")+"#")
                    myBackEnd.addToHistory(itemsForHistory)
                    itemsForHistory=""
                    labelCost.totalcost=0
                    myBackEnd.writeBalance(removeBalance1)
                    myWallet.b = myBackEnd.getBalanceQML()
                    main:view.currentIndex=5
                    //grafoume tin catigoria sto antistoixo arxeio
                    for(var  i=0;i<removeFundsMainRect.categories.length;i++){
                        myBackEnd.writeCategory(removeFundsMainRect.categories[i],removeFundsMainRect.cost[i])
                    }
                }
            }

            id:prodConfirm
            anchors.top:products.bottom
            anchors.topMargin: height/2
            anchors.left:products.left
            anchors.leftMargin: width
            width:parent.width/3
            height:parent.height/10
            Text{
                color:"green"
                text:qsTr("Continue..")
                width:parent.width
                height:parent.height
                font{
                    bold:true
                    family:"Arial"
                    pixelSize:(parent.height+parent.width)/15

                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
//}
}


