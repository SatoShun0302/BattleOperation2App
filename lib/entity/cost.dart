
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// コストテーブルに対応するモデルクラス.
/// (id),コスト,削除フラグ
class Cost {
  @required
  int? id;

  @required
  int? cost;

  @required
  int? isDeleted;

  Cost(this.id, this.cost, this.isDeleted);

  factory Cost.fromDynamic(dynamic record) {
    Cost cost = new Cost(
        record["id"],
        record["cost"],
        record["is_deleted"]);
    return cost;
  }
}