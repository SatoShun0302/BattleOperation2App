import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/repository/map_list_repository.dart';


/// ドロワーメニューを共通化
class DrawerMenu {

  /// アコーディオン形式のドロワーメニューを作成
  Widget expansionPanelList() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _drawerHeader(),
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text('トップへ',
            textScaleFactor: 1,),
          onTap: () {
            Get.off(() => MainScreen());
            print("0-0");
          },
        ),
        ListTile(
          title: Text('DB作成',
            textScaleFactor: 1,),
          onTap: () {
            MapListRepository mlr = new MapListRepository();
            mlr.init();
          },
        ),
        _profileListTile(),
        _battleRecordListTile(),
        _voteListTile(),
        _settingListTile(),
      ],
    );
  }

  // ドロワーヘッダー
  Widget _drawerHeader() {
    return DrawerHeader(
      child: Text('Drawer Header'),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }

  // プロフィール確認、編集
  Widget _profileListTile() {
    return ExpansionTile(
      leading: FaIcon(FontAwesomeIcons.addressCard),
      childrenPadding: EdgeInsets.only(left: ScreenEnv.deviceWidth * 0.1),
      title: Text(
        'プロフィール',
        textScaleFactor: 1,
      ),
      children: <Widget>[
        ListTile(
          title: Text('プロフィール確認',
            textScaleFactor: 1,),
          onTap: () {
            print("1-1");
          },
        ),
        ListTile(
          title: Text('プロフィール編集',
            textScaleFactor: 1,),
          onTap: () {
            print("1-2");
          },
        )
      ],
    );
  }

  // 過去戦績確認、登録
  Widget _battleRecordListTile() {
    return ExpansionTile(
      leading: Icon(Icons.assessment_outlined),
      childrenPadding: EdgeInsets.only(left: ScreenEnv.deviceWidth * 0.1),
      title: Text(
        '戦績',
        textScaleFactor: 1,
      ),
      children: <Widget>[
        ListTile(
          title: Text('過去戦績確認',
            textScaleFactor: 1,),
          onTap: () {
            Get.off(() => MyBattleRecord());
            print("2-1");
          },
        ),
        ListTile(
          title: Text('試合データ登録',
            textScaleFactor: 1,),
          onTap: () {
            print("2-2");
          },
        )
      ],
    );
  }

  // みんなの投票
  Widget _voteListTile() {
    return ExpansionTile(
      leading: Icon(Icons.assignment_rounded),
      childrenPadding: EdgeInsets.only(left: ScreenEnv.deviceWidth * 0.1),
      title: Text(
        'みんなの投票',
        textScaleFactor: 1,
      ),
      children: <Widget>[
        ListTile(
          title: Text('強機体アンケート',
            textScaleFactor: 1,),
          onTap: () {
            print("3-1");
          },
        ),
        ListTile(
          title: Text('弱機体アンケート',
            textScaleFactor: 1,),
          onTap: () {
            print("3-2");
          },
        )
      ],
    );
  }

  // みんなの投票
  Widget _settingListTile() {
    return ExpansionTile(
      leading: FaIcon(FontAwesomeIcons.cog),
      childrenPadding: EdgeInsets.only(left: ScreenEnv.deviceWidth * 0.1),
      title: Text(
        '設定',
        textScaleFactor: 1,
      ),
      children: <Widget>[
        ListTile(
          title: Text('通知設定',
            textScaleFactor: 1,),
          onTap: () {
            print("4-1");
          },
        ),
        ListTile(
          title: Text('データ取得',
            textScaleFactor: 1,),
          onTap: () {
            print("4-2");
          },
        ),
        ListTile(
          title: Text('アプリについて',
            textScaleFactor: 1,),
          onTap: () {
            print("4-3");
          },
        )
      ],
    );
  }
}
