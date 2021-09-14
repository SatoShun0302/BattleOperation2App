import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/model/battle_record.dart';
import 'package:battle_operation2_app/model/battle_record_wingman.dart';
import 'basic_database.dart';
import 'dart:math' as math;

class BattleRecordRepository extends BasicDatabase {
  late Database db;

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    database.then((value) {
      db = value;
    });
  }

  @override
  String get tableName => DatabaseEnv.battleRecordTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// 戦績データを取得する.
  ///
  /// レコード数が膨大なため基本は全件取得はせず、最大1年分とする.
  Future<List<Map<String, dynamic>>> getRecord(
      {required List<int> msId}) async {
    db = await database;
    String _where = "";
    List<Map<String, dynamic>> map = await db.query(
        DatabaseEnv.battleRecordTable,
        where: "ms_id in ? AND is_deleted = 0",
        whereArgs: [msId]);
    return map;
  }

  /// テストデータ挿入
  void initInsertTestRecords() async {
    db = await database;
    // 2ヶ月分（1日5件*60日＝300件)のテストデータを作成する
    int counter = 0;
    DateTime today = new DateTime.now();
    List<BattleRecord> records = [];
    List<int> mapList = [
      1000,
      1001,
      1002,
      1003,
      1004,
      1005,
      1006,
      1007,
      1008,
      1009,
      1010,
      2000,
      2001,
      2002,
      2003
    ];
    List<int> costList = [
      100,
      150,
      200,
      250,
      300,
      350,
      400,
      450,
      500,
      550,
      600,
      650,
      700
    ];
    List<int> numberOfPlayerList = [5, 6];
    List<String> sideList = ["A", "B"];
    List<int> formationList = [141, 231, 51, 132];
    List<int> winOrLose = [0, 1];
    int rateResult = 2400;
    for (int i = 0; i < 300; i++) {
      if (counter >= 5) {
        today = today.add(Duration(days: 1) * -1);
      } else {
        today = today.add(Duration(minutes: 10) * -1);
      }
      var rand = new math.Random();
      List<int> fall = [-12, -10, -8];
      List<int> rise = [12, 10, 8];
      int winOrLoseResult = (winOrLose..shuffle()).first;
      int riseAndFall = winOrLoseResult == 0
          ? (fall..shuffle()).first
          : (rise..shuffle()).first;
      rateResult = (rateResult + riseAndFall);
      BattleRecord battleRecord = new BattleRecord(
          null,
          (rand.nextInt(49) + 1),
          (rand.nextInt(3) + 1),
          (mapList..shuffle()).first,
          (costList..shuffle()).first,
          6,
          (sideList..shuffle()).first,
          (formationList..shuffle()).first,
          (rand.nextInt(6)),
          (winOrLose..shuffle()).first,
          winOrLoseResult,
          ([0, 1]..shuffle()).first,
          ([0, 1]..shuffle()).first,
          (rand.nextInt(12) + 1),
          (rand.nextInt(12) + 1),
          (rand.nextInt(1200)),
          (rand.nextInt(12) + 1),
          (rand.nextInt(1000)),
          (rand.nextInt(12) + 1),
          (rand.nextInt(80000) + 10000),
          (rand.nextInt(12) + 1),
          (rand.nextDouble() * 100),
          (rand.nextInt(12) + 1),
          (rand.nextInt(6)),
          (rand.nextInt(12) + 1),
          (rand.nextInt(6)),
          (rand.nextInt(12) + 1),
          (rand.nextInt(1500)),
          rateResult,
          riseAndFall,
          today.hour,
          today.weekday,
          DateTimeUtil.dateTimeConvertToUnixTime(today),
          0);
      records.add(battleRecord);
      counter++;
    }
    // DBにレコードを挿入する
    List<int> insertResultNum = [];
    await db.transaction((txn) async {
      try {
        await Future.forEach(records, (BattleRecord record) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.battleRecordTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [
                record.id,
                record.msId,
                record.msTypeId,
                record.mapId,
                record.cost,
                record.numberOfPlayer,
                record.side,
                record.formation,
                record.notHighestRankPlayer,
                record.winOrLosePrediction,
                record.winOrLoseResult,
                record.isBlastBase,
                record.rivalWinOrLoseResult,
                record.overallRanking,
                record.personalScoreRanking,
                record.personalScore,
                record.assistScoreRanking,
                record.assistScore,
                record.dealDamageRanking,
                record.dealDamage,
                record.feintRanking,
                record.feint,
                record.msDefeatRanking,
                record.msDefeat,
                record.msLossRanking,
                record.msLoss,
                record.pursuitAssistRanking,
                record.pursuitAssist,
                record.rateResult,
                record.rateRiseAndFall,
                record.timeFrame,
                record.weekdays,
                record.insertDateUnix,
                record.isDeleted
              ]);
          insertResultNum.add(_id);
          // 1試合に紐づく味方の戦績レコード
          for (int j = 0; j <= 5; j++) {
            var rand = new math.Random();
            BattleRecordWingman battleRecordWingman = new BattleRecordWingman(
                null,
                _id,
                (rand.nextInt(49) + 1),
                0);
            int _id2 = await txn.rawInsert(
                'INSERT INTO ${DatabaseEnv.battleRecordWingmanTable} VALUES (?, ?, ?, ?)',
                [
                  battleRecordWingman.id,
                  battleRecordWingman.battleRecordId,
                  battleRecordWingman.msId,
                  battleRecordWingman.isDeleted
                ]);
          }
        });
      } catch (e) {
        print("error");
      }
    });
  }
}
