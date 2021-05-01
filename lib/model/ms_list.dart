import 'package:battle_operation2_app/importer/dart_importer.dart';

/// モビルスーツ一覧テーブルに対応するモデルクラス.
/// (id),機体名,機体レベル,MSタイプ,地上出撃可否,宇宙出撃可否,コスト
/// 公式画像url,wiki画像url,wikiサイトurl
class MsList {
  int? id;
  String? msName;
  int? msLevel;
  String? msType;
  int? canGround;
  int? canSpace;
  int? cost;
  String? officialPicUrl;
  String? wikiPicUrl;
  String? wikiPageUrl;
  int? isFavorite;
  int? isDeleted;

  MsList(
      @required this.msName,
      @required this.msLevel,
      @required this.msType,
      @required this.canGround,
      @required this.canSpace,
      @required this.cost,
      @required this.officialPicUrl,
      @required this.wikiPicUrl,
      @required this.wikiPageUrl,
      @required this.isFavorite,
      @required this.isDeleted
      );
}
