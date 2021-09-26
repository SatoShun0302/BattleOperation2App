import 'package:battle_operation2_app/importer/dart_importer.dart';

class BattleRecordWingman {
  int? id;

  @required
  int battleRecordId;

  @required
  int msId;

  @required
  int isDeleted;

  BattleRecordWingman(
      this.id,
      this.battleRecordId,
      this.msId,
      this.isDeleted);

  factory BattleRecordWingman.fromDynamic(dynamic record) {
    BattleRecordWingman battleRecordWingman = new BattleRecordWingman(
        record["id"],
        record["battle_record_id"],
        record["ms_id"],
        record["is_deleted"]);
    return battleRecordWingman;
  }
}
