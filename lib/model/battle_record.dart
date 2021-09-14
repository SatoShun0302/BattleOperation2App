import 'package:battle_operation2_app/importer/dart_importer.dart';

class BattleRecord {
  int? id;

  @required
  int msId;

  @required
  int msTypeId;

  @required
  int mapId;

  @required
  int cost;

  /// チーム人数
  @required
  int numberOfPlayer;

  /// チームサイド A or B
  @required
  String side;

  /// チーム編成
  @required
  int formation;

  /// 最高ランク帯でないプレイヤーの数 0~5
  @required
  int notHighestRankPlayer;

  /// 勝敗予想 0:敗北, 1:勝利.
  @required
  int winOrLosePrediction;

  /// 勝敗結果 0:敗北, 1:勝利.
  @required
  int winOrLoseResult;

  /// 拠点爆破 0:なし または 失敗, 1:成功.
  @required
  int isBlastBase;

  /// ライバル勝敗結果 0:敗北, 1:勝利.
  @required
  int rivalWinOrLoseResult;

  /// 総合個人順位.
  @required
  int overallRanking;

  /// 個人スコア順位.
  @required
  int personalScoreRanking;

  /// 個人スコア.
  @required
  int personalScore;

  /// アシストスコア順位.
  @required
  int assistScoreRanking;

  /// アシストスコア.
  @required
  int assistScore;

  /// 与ダメージ順位.
  @required
  int dealDamageRanking;

  /// 与ダメージ.
  @required
  int dealDamage;

  /// 陽動順位.
  @required
  int feintRanking;

  /// 陽動.
  @required
  double feint;

  /// MS撃破順位.
  @required
  int msDefeatRanking;

  /// MS撃破.
  @required
  int msDefeat;

  /// MS損失順位.
  @required
  int msLossRanking;

  /// MS損失.
  @required
  int msLoss;

  /// 追撃アシスト順位.
  @required
  int pursuitAssistRanking;

  /// 追撃アシスト.
  @required
  int pursuitAssist;

  /// 試合後レート
  @required
  int rateResult;

  /// 時間帯 ex.0時:0, 12時:12, 22時:22.
  @required
  int timeFrame;

  /// レート増減
  @required
  int rateRiseAndFall;

  /// 曜日
  @required
  int weekdays;

  /// データ登録日時
  @required
  int insertDateUnix;

  @required
  int isDeleted;

  BattleRecord(
      this.id,
      this.msId,
      this.msTypeId,
      this.mapId,
      this.cost,
      this.numberOfPlayer,
      this.side,
      this.formation,
      this.notHighestRankPlayer,
      this.winOrLosePrediction,
      this.winOrLoseResult,
      this.isBlastBase,
      this.rivalWinOrLoseResult,
      this.overallRanking,
      this.personalScoreRanking,
      this.personalScore,
      this.assistScoreRanking,
      this.assistScore,
      this.dealDamageRanking,
      this.dealDamage,
      this.feintRanking,
      this.feint,
      this.msDefeatRanking,
      this.msDefeat,
      this.msLossRanking,
      this.msLoss,
      this.pursuitAssistRanking,
      this.pursuitAssist,
      this.rateResult,
      this.rateRiseAndFall,
      this.timeFrame,
      this.weekdays,
      this.insertDateUnix,
      this.isDeleted);

  factory BattleRecord.fromDynamic(dynamic record) {
    BattleRecord battleRecord = new BattleRecord(
        record["id"],
        record["ms_id"],
        record["ms_type_id"],
        record["map_id"],
        record["cost"],
        record["number_of_player"],
        record["side"],
        record["formation"],
        record["not_highest_rank_player"],
        record["win_or_lose_prediction"],
        record["win_or_lose"],
        record["is_blast_base"],
        record["rival_win_or_lose_result"],
        record["overall_ranking"],
        record["personal_score_ranking"],
        record["personal_score"],
        record["assist_score_ranking"],
        record["assist_score"],
        record["deal_damage_ranking"],
        record["deal_damage"],
        record["feint_ranking"],
        record["feint"],
        record["ms_defeat_ranking"],
        record["ms_defeat"],
        record["ms_loss_ranking"],
        record["ms_loss"],
        record["pursuit_assist_ranking"],
        record["pursuit_assist"],
        record["rate_result"],
        record["rate_rise_and_fall"],
        record["time_frame"],
        record["weekdays"],
        record["insert_date_unix"],
        record["is_deleted"]);
    return battleRecord;
  }
}
