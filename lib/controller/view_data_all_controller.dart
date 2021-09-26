import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_data_view.dart';

/// 過去
class AllDataViewController extends GetxController {

  /// 選択されたチーム人数, 初期選択は6人.
  RxInt numberOfChosenPlayer = 6.obs;

  /// 地上と宇宙のどちらが選択されているか, 初期選択は地上=true.
  RxBool isChosenGround = true.obs;

  /// 選択されている人数およびマップの条件に対応したデータ保持クラスのパラメーター.
  AllDataView? chosenData;

  /// 地上の総合戦績データを保持するパラメーター（5人チーム）.
  AllDataView? allGroundDataView5;

  /// 地上の総合戦績データを保持するパラメーター（6人チーム）.
  AllDataView? allGroundDataView6;

  /// 宇宙の総合戦績データを保持するパラメーター（5人チーム).
  AllDataView? allSpaceDataView5;

  /// 宇宙の総合戦績データを保持するパラメーター（6人チーム).
  AllDataView? allSpaceDataView6;

  Future<AllDataView?> getData() async {
    switch (numberOfChosenPlayer.value) {
      case 5:
        if (isChosenGround.value) {
          chosenData = await getAllGroundDataView5();
        } else {
          chosenData = await getAllSpaceDataView5();
        }
        break;
      case 6:
        if (isChosenGround.value) {
          chosenData = await getAllGroundDataView6();
        } else {
          chosenData = await getAllSpaceDataView6();
        }
        break;
    }
    return chosenData;
  }

  /// 人数が5人かつ地上の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  ///
  /// @return AllGroundDataView5のインスタンスまたはnull.
  Future<AllDataView?> getAllGroundDataView5() async {
    if (allGroundDataView5 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView(numberOfPlayer: 5);
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allGroundDataView5 = new AllDataView();
        allGroundDataView5!.init(_records);
      }
      return allGroundDataView5;
    } else {
      return allGroundDataView5;
    }
  }

  /// 人数が6人かつ地上の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  ///
  /// @return AllGroundDataView5のインスタンスまたはnull.
  Future<AllDataView?> getAllGroundDataView6() async {
    if (allGroundDataView6 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView();
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allGroundDataView6 = new AllDataView();
        allGroundDataView6!.init(_records);
      }
      return allGroundDataView6;
    } else {
      return allGroundDataView6;
    }
  }

  /// 人数が5人かつ宇宙の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  Future<AllDataView?> getAllSpaceDataView5() async {
    if (allSpaceDataView5 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView(
          numberOfPlayer: 5,
          isChosenGround: false
      );
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allSpaceDataView5 = new AllDataView();
        allSpaceDataView5!.init(_records);
      }
      return allSpaceDataView5;
    } else {
      return allSpaceDataView5;
    }
  }

  /// 人数が6人かつ宇宙の場合の戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  Future<AllDataView?> getAllSpaceDataView6() async {
    if (allSpaceDataView6 == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesAllDataView(
          isChosenGround: false
      );
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        allSpaceDataView6 = new AllDataView();
        allSpaceDataView6!.init(_records);
      }
      return allSpaceDataView6;
    } else {
      return allSpaceDataView6;
    }
  }
}