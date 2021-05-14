import BackEnd 1.0
import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 1.4 as Qtc1
import QtQuick.Controls 2.3

Rectangle {
    property var categories:[]
    property int newCategory:0
    id:mainRect
    anchors.fill: parent
    color:"lightSteelBlue"
    BackEnd{
        id:myBackEnd
    }
   Qtc1.TableView {
        width:parent.width
        height:parent.height*2/3
        id: products
        alternatingRowColors: true
       Qtc1.TableViewColumn {
            role: "title"
            title: "Title"
            width: parent.width/2
            movable: false
        }
        Qtc1.TableViewColumn {
            role: "cost"
            title: "Cost"
            width: parent.width/2
            movable:false

        }
            /*onPressAndHold: {
                mediator.removeItem(currentRow)
            }*/
        model:mediator.myModel
    }


    Rectangle{
        color:"lightSteelBlue"
        width:parent.width
        anchors.top:products.bottom
        height:parent.height/3
        Rectangle{
            color:"lightSteelBlue"
            x: width/4
            y: height/2
            width:parent.width/2
            height:parent.height/2
            Button{
                id:addProduct
                width:parent.width/2
                height:parent.height/2
                Text{
                    color:"green"
                    text:"Add Item"
                    anchors.centerIn: parent
                    font{
                        bold:true
                        pixelSize:(parent.height+parent.width)/12
                    }
                }
                onClicked: {
                    additems.visible=true
                    myLV.visible=true
                    products.enabled=false
                    addProduct.enabled=false
                    removeProduct.enabled=false
                }
            }
            Button{
                id:removeProduct
                width:parent.width/2
                height:parent.height/2
                anchors.left:addProduct.right
                anchors.leftMargin: width/4
                Text{
                    color:"red"
                    text:"Remove Item"
                    anchors.centerIn: parent
                    font{
                        bold:true
                        pixelSize:(parent.height+parent.width)/12
                    }
                }
                onClicked:{
                    if(products.currentRow!=-1)
                    mediator.removeItem(products.currentRow)
                }
            }
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
            main:view.currentIndex=1;
        }

    }
    Rectangle{
        color:"lightblue"
        id:additems
        visible:false
        width:parent.width/1.1
        height:parent.height/1.1
        anchors.centerIn: parent

        Rectangle {
            color:"lightBlue"
            width:parent.width
            height:parent.height*2/3
            id: textRect
            Rectangle{
                color:"white"
                x:parent.x+parent.width/3
                y:parent.y+parent.height/4
                width: parent.width/3
                height: parent.height/8
                id:textRect1
                TextEdit{
                    clip:true
                    id:textName
                    color:"#aaa"
                    property string hint: "Item name"
                    text: hint
                    wrapMode: TextEdit.Wrap
                    anchors.fill: parent
                    onFocusChanged: {
                        if (text == hint) {
                            text=""
                            color="black"
                        }
                    }
                }
            }
            Rectangle{
                color:"white"
                anchors.top:textRect1.bottom
                anchors.left:textRect1.left
                anchors.topMargin: height/2
                width: parent.width/3
                height: parent.height/8
                id:textRect2
                    TextEdit{
                        clip:true
                        id:textCost
                        color:"#aaa"
                        text: hint
                        wrapMode: TextEdit.Wrap
                        anchors.fill: parent
                        property string hint: "Cost"
                        onFocusChanged: {
                            if(text==hint){
                                text=""
                                color="black"
                            }
                        }
                    }
            }
            ListView{
                visible:false
                 id:myLV
                 width:parent.width/3
                 height:parent.height/3
                 anchors.top:textRect2.bottom
                 anchors.left:textRect2.left
                 anchors.topMargin:height/4
                 model:myLVmodel
                 highlight: Rectangle{
                     color:"lightgreen"
                 }
                 delegate: myDelegate
                 onVisibleChanged: {//katagrafi twn categories sto list view kai diagrafi twn diplotipwn
                     myLVmodel.clear()
                     var i=0;
                     mainRect.categories=[];
                     var count=products.rowCount;
                     if(products.rowCount==1){
                         myLVmodel.append({"name":mediator.getCategory(0)})
                         mainRect.categories.push(mediator.getCategory(0));
                         if(mediator.getCategory(0)!=="Other"){
                         myLVmodel.append({"name":"Other"})
                         mainRect.categories.push("Other");
                         }
                     }
                     else{
                         var otherCount=0;
                     for(i;i<=count-1;i++){
                         var temp=mediator.getCategory(i);
                         var isOther=mediator.getCategory(i)
                         if(isOther==="Other"){
                             otherCount++
                         }

                         var j=i+1;
                         var test=0;
                         for(j;j<=count-1;j++){
                            if(temp===mediator.getCategory(j)){
                                test++
                            }
                         }
                         if(test==0){
                             myLVmodel.append({"name": temp})
                              mainRect.categories.push(temp);
                         }
                     }
                     if(otherCount==0){
                     myLVmodel.append({"name":"Other"})
                     mainRect.categories.push("Other");
                     }
                     }


                 }
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
                 height:myLV.height/3
                 RowLayout{
                     anchors.fill: parent
                     Label{
                         verticalAlignment: "AlignVCenter"
                         text:name
                     }
                 }
                 MouseArea{
                     acceptedButtons: Qt.LeftButton | Qt.RightButton
                     anchors.fill: parent
                     onClicked: {
                         myLV.currentIndex = index
                     }

                 }
             }

            }
           Rectangle{
               visible:false
               color:"white"
               anchors.top:addCategory.bottom
               anchors.topMargin: height/2
               anchors.left:addCategory.left
               width: parent.width/4
               height: parent.height/10
               id:textCategory
                   TextEdit{
                       clip:true
                       id:textAddCategory
                       color:"#aaa"
                       text: hint
                       wrapMode: TextEdit.Wrap
                       anchors.fill: parent
                       property string hint: "Describe Category"
                       onFocusChanged: {
                           if(text==hint){
                               text=""
                               color="black"
                           }
                       }
                   }
           }
           Button{
               onClicked:{
                   textCategory.visible=true
                   mainRect.newCategory=1
                   myLV.visible=false
               }

               id:addCategory
               width:parent.width/5
               height:parent.height/10
               anchors.left:myLV.right
               anchors.leftMargin:width/3
               anchors.top:myLV.top
               Text{
                   color:"black"
                   text:qsTr("Add Category")
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

        Button{
            onClicked:{
                additems.visible=false
                myLV.visible=false
                textCost.text=textCost.hint
                textName.text=textName.hint
                textCost.color="#aaa"
                textName.color="#aaa"
                products.enabled=true
                addProduct.enabled=true
                removeProduct.enabled=true
                mainRect.newCategory=0
                textCategory.visible=false
                mainRect.newCategory=0
            }

            id:addprodCancel
            y:(parent.height+textRect.height)/2
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
        }
        Button{
            onClicked:{
                additems.visible=false
                myLV.visible=false
                if(mainRect.newCategory==1){
                    mainRect.newCategory=0
                    if(textAddCategory.text==="Describe Category"){
                        textAddCategory.text="Other"
                    }

                    mediator.insertItem(textName.text,textCost.text,textAddCategory.text)
                    myBackEnd.addItem(textName.text,textCost.text,textAddCategory.text)
                    textAddCategory.text=textAddCategory.hint
                    textAddCategory.color="#aaa"
                    textCategory.visible=0
                }
                else{
                    mediator.insertItem(textName.text,textCost.text,mainRect.categories[myLV.currentIndex])
                    myBackEnd.addItem(textName.text,textCost.text,mainRect.categories[myLV.currentIndex])
                }
                textCost.text=textCost.hint
                textName.text=textName.hint
                textCost.color="#aaa"
                textName.color="#aaa"
                products.enabled=true
                addProduct.enabled=true
                removeProduct.enabled=true
                myLV.visible=true

            }

            id:addprodConfirm
            y:(parent.height+textRect.height)/2
            x:3*addprodCancel.x + addprodCancel.width
            width:parent.width/3
            height:parent.height/10
            Text{
                color:"green"
                text:qsTr("Confirm")
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

}






