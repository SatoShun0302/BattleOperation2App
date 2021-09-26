import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_ground_data_view5.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_ground_data_view6.dart';

/// 過去
class AllDataViewController extends GetxController {

  /// 選択されたチーム人数, 初期選択は6人.
  RxInt numberOfChosenPlayer = 5.obs;

  /// 地上と宇宙のどちらが選択されているか, 初期選択は地上=true.
  RxBool isChosenGround = true.obs;

  /// 地上の総合戦績データを保持するクラス（5人チーム）.
  AllGroundDataView5? allGroundDataView5;

  /// 地上の総合戦績データを保持するクラス（6人チーム）.
  AllGroundDataView6? allGroundDataView6;

  /// 人数が5人の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  ///
  /// @return AllGroundDataView5のインスタンスまたはnull.
  Future<AllGroundDataView5?> getAllGroundDataView5() async {
    if (allGroundDataView5 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView();
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allGroundDataView5 = new AllGroundDataView5();
        allGroundDataView5!.init(_records);
      }
      return allGroundDataView5;
    } else {
      return allGroundDataView5;
    }
  }

  /// 人数が6人の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  ///
  /// @return AllGroundDataView5のインスタンスまたはnull.
  Future<AllGroundDataView6?> getAllGroundDataView6() async {
    if (allGroundDataView6 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView();
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allGroundDataView6 = new AllGroundDataView6();
        allGroundDataView6!.init(_records);
      }
      return allGroundDataView6;
    } else {
      return allGroundDataView6;
    }
  }
}