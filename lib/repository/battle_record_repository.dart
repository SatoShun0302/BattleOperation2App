import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/entity/battle_record_wingman.dart';
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

  /// 総合戦績画面で使用する過去1年分の総合戦績データを取得する.
  ///
  Future<List<BattleRecord>> getRecordUsesAllDataView(
      {int numberOfPlayer = 6, int durationDays = -365, bool isChosenGround = true}) async {
    DateTime _dateTime = DateTime.now().add(Duration(days: durationDays));
    String _where = isChosenGround ?
    "number_of_player = ? AND map_id BETWEEN 1000 AND 1999 AND insert_date_unix >= ? AND is_deleted = 0" :
    "number_of_player = ? AND map_id BETWEEN 2000 AND 2999 AND insert_date_unix >= ? AND is_deleted = 0";
    db = await database;
    List<Map<String, dynamic>> map = await db.query(
        DatabaseEnv.battleRecordTable,
        where: _where,
        whereArgs: [numberOfPlayer, DateTimeUtil.dateTimeConvertToUnixTime(_dateTime)]);
    List<BattleRecord> _list = [];
    map.forEach((e) {
      _list.add(BattleRecord.fromDynamic(e));
    });
    return _list;
  }

  /// マップ別戦績画面で使用する過去1年分の総合戦績データを取得する.
  ///
  Future<List<BattleRecord>> getRecordUsesFocusOnMapView(
      {required int numberOfPlayer, required int mapId, int durationDays = -365}) async {
    DateTime _dateTime = DateTime.now().add(Duration(days: durationDays));
    String _where = "number_of_player = ? AND map_id = ? AND insert_date_unix >= ? AND is_deleted = 0";
    db = await database;
    List<Map<String, dynamic>> map = await db.query(
        DatabaseEnv.battleRecordTable,
        where: _where,
        whereArgs: [numberOfPlayer, mapId, DateTimeUtil.dateTimeConvertToUnixTime(_dateTime)]);
    List<BattleRecord> _list = [];
    map.forEach((e) {
      _list.add(BattleRecord.fromDynamic(e));
    });
    return _list;
  }

  /// テストデータ挿入
  void initInsertTestRecords() async {
    db = await database;
    // 2ヶ月分（1日10件*60日＝600件)のテストデータを作成する
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
    List<String> sideList = ["A", "B"];
    List<int> formationList = [141, 231, 51, 132];
    List<int> formationList2 = [131, 221, 41, 14];
    List<int> winOrLose = [0, 1];
    int rateResult = 2400;
    var rand = new math.Random();
    for (int i = 0; i < 600; i++) {
      if (counter >= 10) {
        today = today.add(Duration(days: 1) * -1);
        counter = 0;
        int _hour = rand.nextInt(24);
        today = new DateTime(today.year, today.month, today.day, _hour, today.minute);
      } else {
        today = today.add(Duration(minutes: 10) * -1);
      }
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
      BattleRecord battleRecord2 = new BattleRecord(
          null,
          (rand.nextInt(49) + 1),
          (rand.nextInt(3) + 1),
          (mapList..shuffle()).first,
          (costList..shuffle()).first,
          5,
          (sideList..shuffle()).first,
          (formationList2..shuffle()).first,
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
          DateTimeUtil.dateTimeConvertToUnixTime(today)+1,
          0);
      records.add(battleRecord);
      records.add(battleRecord2);
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
