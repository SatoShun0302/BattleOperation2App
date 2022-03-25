
import 'package:battle_operation2_app/entity/mobile_suit.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/ms_list_repository.dart';

/// MS一覧
class MobileSuitController extends GetxController {
  /// MSリスト
  List<MobileSuit> msList = [];

  /// MSドロップダウンリスト
  List<DropdownMenuItem<Map<int, String>>> msDropdownList = [];

  String hint = "Search";

  /// データベースに登録済みの全ての機体を取得する（機体名で重複を省く）
  Future<List<MobileSuit>> getAllMobileSuit() async {
    if (msList.isEmpty) {
      Stopwatch sw = new Stopwatch();
      sw.start();
      MsListRepository msListRepository = new MsListRepository();
      msList = await msListRepository.getRecord();
      sw.stop();
      print('========================${sw
          .elapsedMilliseconds} ms==============================');
    }
    return msList;
  }

  /// DBへ新機体をinsertする.
  void insertNewMsRecord(String lines) {
    List<MobileSuit> _msList = [];
    for (String _line in lines.split("\r\n")) {
      List _rows = _line.split(",");
      MobileSuit _ms = new MobileSuit(
          null,
          _rows[1],
          int.parse(_rows[2]),
          int.parse(_rows[3]),
          int.parse(_rows[4]),
          int.parse(_rows[5]),
          int.parse(_rows[6]),
          _rows[7],
          _rows[8],
          _rows[9],
          int.parse(_rows[10]),
          int.parse(_rows[11]));
      _msList.add(_ms);
    }
  }

  /// 新機体がDBに追加された場合など、取得済みのmsListを空にする.
  ///
  /// また、
  void clearMsList() {
    msList = [];
  }
}