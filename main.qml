import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import BackEnd 1.0

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Money Management")
    color:"#9eb4cc"
    SwipeView{
        id: view
        Item{
            id:commonExpenses
            CommonExpenses{

            }
        }
        Item{
            id:settings
            Settings{

            }
        }
        Item{
            id:homePage
            Home{
            }
        }
        Item{
            id:myWallet
            property string b: myBackEnd.getBalanceQML();
            MyWallet{
            }
        }
        Item{
            //property alias removeBalance1:view.removeBalance
            id:removeFunds
            RemoveFunds{
            }
        }

        Item{
            id:removeFunds2
            //property alias removeBalance2:view.removeBalance
            RemoveFunds2{

            }
        }
        currentIndex: 2
        anchors.fill: parent
        contentItem: interactive = false
    }
    BackEnd{
        id:myBackEnd
    }

}
