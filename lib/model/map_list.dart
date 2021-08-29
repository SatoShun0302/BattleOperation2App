import 'package:battle_operation2_app/importer/dart_importer.dart';

/// マップ一覧テーブルに対応するモデルクラス.
/// (id),マップID,マップ名,公式画像url,非公式画像url,削除フラグ
class MapList {
  @required
  int? id;

  @required
  int? mapId;

  @required
  String? mapName;

  String? officialPicUrl;
  String? wikiPicUrl;

  @required
  int? isDeleted;

  MapList(this.id, this.mapId, this.mapName, this.officialPicUrl,
      this.wikiPicUrl, this.isDeleted);

  factory MapList.fromDynamic(dynamic record) {
      MapList mapList = new MapList(
          record["id"],
          record["map_id"],
          record["map_name"],
          record["official_pic_url"],
          record["official_pic_url"],
          record["is_deleted"]);
    return mapList;
  }
}
