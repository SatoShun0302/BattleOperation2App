import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// アプリ起動後最初に表示される画面
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得しscreen_envへ格納する
    ScreenEnv.deviceWidth = MediaQuery.of(context).size.width;
    ScreenEnv.deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.orange,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: new DrawerMenu().expansionPanelList(),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Column(
        children: <Widget>[
          Card(
            color: Colors.blue,
            margin: EdgeInsets.only(
                top: ScreenEnv.deviceHeight * 0.015,
                right: ScreenEnv.deviceHeight * 0.01,
                bottom: ScreenEnv.deviceHeight * 0.015,
                left: ScreenEnv.deviceHeight * 0.01),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                    ),
                    height: ScreenEnv.deviceHeight * 0.2,
                    width: ScreenEnv.deviceWidth * 0.6,
                    margin: EdgeInsets.all(ScreenEnv.deviceHeight * 0.01),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Text("Name:"),
                                  ),
                                  Expanded(
                                    child: Text("aaa"),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("bbb"),
                                  ),
                                  Expanded(
                                    child: Text("bbb"),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    height: ScreenEnv.deviceHeight * 0.2,
                    margin:
                        EdgeInsets.only(right: ScreenEnv.deviceHeight * 0.01),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenEnv.deviceHeight * 0.022,
                            bottom: ScreenEnv.deviceHeight * 0.022),
                        child: Text("right")),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
