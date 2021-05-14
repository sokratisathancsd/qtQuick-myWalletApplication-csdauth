import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls 2.3
import BackEnd 1.0
import QtCharts 2.2
import QtQuick.Controls 1.4 as Qtc1
import QtQuick.Controls.Styles 1.4

Rectangle {
    property var tempDatesList:[]
    id:mainRect
    property var categories:[]
    anchors.fill: parent
    color:"lightSteelBlue"
    BackEnd{
        id:myBackEnd
    }
    Button{
        id:commonExpenses
        width:parent.width/2
        height:parent.height/15
        x:parent.width/4
        y:parent.height/8
        topPadding: 12
        onClicked: {
            main:view.currentIndex=0
        }

        Text{
            width:parent.width
            height:parent.height
            text:qsTr("Common Expenses")
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
        id:history
        onClicked:{
           historyMainRect.visible=true
            commonExpenses.enabled=false
            chartsshow.enabled=false
            tutorial.enabled=false
        }
        width:parent.width/2
        height:parent.height/15
        y:commonExpenses.y+2*commonExpenses.height
        x:parent.width/4
        Text{
            width:parent.width
            height:parent.height
            text:qsTr("View History")
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
        id:chartsshow
        width:parent.width/2
        height:parent.height/15
        y:history.y+2*history.height
        x:parent.width/4
        Text{
            width:parent.width
            height:parent.height
            text:qsTr("Charts")
            color:"black"
            font{
                bold:true
                family:"Arial"
                pixelSize: (parent.height+parent.width)/12
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked:{
             charts.visible=true
            commonExpenses.enabled=false
            history.enabled=false
            tutorial.enabled=false
        }

    }
    Button{
        id:tutorial
        width:parent.width/2
        height:parent.height/15
        y:chartsshow.y+2*chartsshow.height
        x:parent.width/4
        onClicked: {
            myBackEnd.deleteAll()
        }

        Text{
            width:parent.width
            height:parent.height
            text:qsTr("Clear All")
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
    Rectangle{
        id:charts
        visible:false
        anchors.fill:parent
    ChartView {
        Button{
            width:parent.width/7
            height:parent.width/7
            anchors.bottom:parent.bottom
            anchors.right:parent.right
            anchors.bottomMargin:height/2
            anchors.rightMargin:width/2
            Text{
                width:parent.width
                height:parent.height
                text:qsTr("Return")
                color:"black"
                font{
                    bold:true
                    family:"Arial"
                    pixelSize: (parent.height+parent.width)/12
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked:{
                charts.visible=false
                commonExpenses.enabled=true
                history.enabled=true
                tutorial.enabled=true
            }

        }
        id:myChartView
        anchors.fill:parent
        theme: ChartView.ChartThemeBlueCerulean//BrownSand
        antialiasing: true
        PieSeries {
            id: pieSeries
            /*PieSlice{label:"Beers";value:40}
            PieSlice{label:"Supermarket";value:30}
            PieSlice{label:"Cofee";value:20}
            PieSlice{label:"Other";value:10}*/

        }
        onVisibleChanged: {
            pieSeries.clear()
            var i=0;
            mainRect.categories=[];
            var count=products.rowCount;
            if(products.rowCount==1){
                mainRect.categories.push(mediator.getCategory(0));
            }
            else{
            for(i;i<=count-1;i++){
                var temp=mediator.getCategory(i);
                var j=i+1;
                var test=0;
                for(j;j<=count-1;j++){
                   if(temp===mediator.getCategory(j)){
                       test++
                   }
                }
                if(test==0){
                    test=0;
                     mainRect.categories.push(temp);

                }

            }
            var allcl=myBackEnd.returnAllChartLines();
            for(var h=0;h<mainRect.categories.length;h++){
                var times=myBackEnd.dataChart(mainRect.categories[h])
                pieSeries.append(mainRect.categories[h],100*(times/allcl))
            }

            }
            for (var p = 0; p < pieSeries.count; p++) {
                    pieSeries.at(p).labelPosition = PieSlice.LabelInsideNormal;
                    pieSeries.at(p).labelVisible = true;
                    pieSeries.at(p).borderWidth = 2;
                }
            myChartView.legend.visible=false;

        }

    }
    }
    Rectangle{
        id:historyMainRect
        anchors.fill: parent
        visible:false
        color:"darkblue"

        Rectangle{
            id:dates
            anchors.top:historyMainRect.top
            width:historyMainRect.width
            height:historyMainRect.height*1/3
            color:"lightsteelblue"
            ComboBox {
                id:box
                model:ListModel{
                    id:myComboModel
                }//[ "Banana", "Apple", "Coconut" ]
                anchors.centerIn: parent
                width: parent.width/2
                height:parent.height/2
                onCurrentIndexChanged: {
                   dateDataText.text = myBackEnd.getDateData(box.textAt(box.currentIndex))

                }
            }
            onVisibleChanged: {
                var lines=myBackEnd.historyLines()
                myComboModel.clear()
                mainRect.tempDatesList=[]
                for(var i=0;i<lines;i++){
                    mainRect.tempDatesList.push(myBackEnd.getDate(i))
                    //myModel.append({text:myBackEnd.getDate(i)})//getstring from backend!
                }
                //katastrofi diplotupwn tis listas tempDateList
                if(mainRect.tempDatesList.length===1){
                    myComboModel.append({text:tempDatesList[0]})
                }
                else{
                for(var j=0;j<mainRect.tempDatesList.length;j++){
                    var temp=mainRect.tempDatesList[j]
                    var count=0
                    for(var h=j+1;h<mainRect.tempDatesList.length;h++){
                        if(temp===mainRect.tempDatesList[h]){
                            count++
                        }
                    }
                    if(count==0){
                        myComboModel.append({text:tempDatesList[j-1]})
                    }
                }
                //elegxos gia to teleutaio stoixeio
                var temp2=mainRect.tempDatesList[mainRect.tempDatesList.length-1]
                var count2=0
                for(var k=0;k<mainRect.tempDatesList.length-1;k++){
                    if(temp===mainRect.tempDatesList[k]){
                        count2++
                    }

                }
                if (count2==0){
                    myComboModel.append({text:tempDatesList[mainRect.tempDatesList.length-1]})
                }
                }




            }
        }
        Rectangle{
            //enabled: false
            color:"lightsteelblue"
            id:historyData
            width:historyMainRect.width
            height:historyMainRect.height*2/3
            anchors.top:dates.bottom
            ScrollView{
                id:scrollView
                anchors.fill: parent
                TextArea{
                    anchors.fill: parent
                    id:dateDataText
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
            Text{
                width:parent.width
                height:parent.height
                text:qsTr("Return")
                color:"black"
                font{
                    bold:true
                    family:"Arial"
                    pixelSize: (parent.height+parent.width)/12
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked:{
                historyMainRect.visible=false
                commonExpenses.enabled=true
                chartsshow.enabled=true
                tutorial.enabled=true
            }

        }
    }

    Qtc1.TableView {
         visible:false
         id: products
        Qtc1.TableViewColumn {
             role: "title"
             title: "Title"
             width: parent.width/2
         }
         Qtc1.TableViewColumn {
             role: "cost"
             title: "Cost"
             width: parent.width/2
         }
         model:mediator.myModel
     }

}
