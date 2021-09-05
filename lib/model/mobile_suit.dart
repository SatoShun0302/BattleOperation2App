import 'package:battle_operation2_app/importer/dart_importer.dart';

/// モビルスーツ一覧テーブルに対応するモデルクラス.
///
/// (id),機体名,機体レベル,MSタイプ,地上出撃可否,宇宙出撃可否,コスト
/// 公式画像url,wiki画像url,wikiサイトurl
class MobileSuit {
  @required
  int? id;

  @required
  String? msName;

  @required
  int? msLevel;

  @required
  int? msType;

  @required
  int? canGround;

  @required
  int? canSpace;

  @required
  int? cost;

  String? officialPicUrl;
  String? wikiPicUrl;
  String? wikiPageUrl;
  int? isFavorite;

  @required
  int? isDeleted;

  MobileSuit(this.id, this.msName, this.msLevel, this.msType, this.canGround, this.canSpace, this.cost,
      this.officialPicUrl, this.wikiPicUrl, this.wikiPageUrl, this.isFavorite, this.isDeleted);

  factory MobileSuit.fromDynamic(dynamic record) {
    MobileSuit mobileSuit = new MobileSuit(
      record["id"],
      record["ms_name"],
      record["ms_level"],
      record["ms_type"],
      record["can_ground"],
      record["can_space"],
      record["cost"],
      record["official_pic_url"],
      record["wiki_pic_url"],
      record["wiki_page_url"],
      record["is_favorite"],
      record["is_deleted"]);
    return mobileSuit;
  }
}
