import 'package:battle_operation2_app/importer/dart_importer.dart';

/// マップ一覧テーブルに対応するモデルクラス.
/// (id),マップID,マップ名,公式画像url,非公式画像url,削除フラグ
class MapList {
  int? id;
  int? mapId;
  String? mapName;
  String? officialPicUrl;
  String? wikiPicUrl;
  int? isDeleted;

  MapList(
      @required this.mapId,
      @required this.mapName,
      @required this.officialPicUrl,
      @required this.wikiPicUrl,
      @required this.isDeleted
      );
}