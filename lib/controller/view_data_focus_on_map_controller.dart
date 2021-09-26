import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_data_view.dart';
import 'package:battle_operation2_app/service/battle_record_view/focus_on_map_view.dart';

class ViewDataFocusOnMapController extends GetxController {

  /// 選択されたチーム人数, 初期選択は6人.
  RxInt numberOfChosenPlayer = 6.obs;

  /// 選択されたマップのID.
  RxInt chosenMapId = 0.obs;

  /// 選択されたマップIDとチーム人数に応じて生成されたインスタンスを保持する.
  Map<String, FocusOnMapView?> focusOnMapViewMap = {};

  /// マップ別戦績データクラスのインスタンスを,レコードが0件の場合はnullを返す.
  ///
  /// @return FocusOnMapViewのインスタンスまたはnull.
  Future<FocusOnMapView?> getData() async {
    FocusOnMapView? _focusOnMapView = focusOnMapViewMap.containsKey(_createKey())
        ? focusOnMapViewMap[_createKey()]
        : null;
    if (_focusOnMapView == null) {
      // 人数,地上または宇宙,期間を指定し、データを取得する
      BattleRecordRepository _battleRecordRepository = new BattleRecordRepository();
      List<BattleRecord> _records = await _battleRecordRepository.getRecordUsesFocusOnMapView(
          numberOfPlayer: numberOfChosenPlayer.value,
          mapId: chosenMapId.value
      );
      // 取得したレコードが0件でなかった場合は総合戦績データのインスタンスを生成
      if (_records.isNotEmpty) {
        _focusOnMapView = new FocusOnMapView();
        bool _isSuccess = _focusOnMapView.init(_records);
        focusOnMapViewMap[_createKey()] = _isSuccess ? _focusOnMapView : null;
      }
    }
    return _focusOnMapView;
  }

  /// 選択中のマップIDとチーム人数に応じて、Mapで使用するkeyを返す.
  String _createKey() {
    return "mapId=${chosenMapId.value}-playerNum=${numberOfChosenPlayer.value}";
  }
}