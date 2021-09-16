
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';

class AllData {
  /// 地上と宇宙どちらが選択されているかのフラグ,初期選択は地上.
  bool isChosenGround = true;

  /// レコード数(出撃回数)
  int totalRecordNum = 0;

  /// 勝利数
  int totalWinNum = 0;

  /// 敗北数
  int totalLoseNum = 0;

  /// 勝率, 勝利数/出撃回数*100, 少数第二位まで表示.
  double winRate = 0.0;

  /// 取得レコードのうち強襲機に登場した回数.
  int numberOfRaidUses = 0;

  /// 強襲機に登場し、勝利した回数.
  int winNumWhileUsingRaid = 0;

  /// 強襲機搭乗時の勝率.
  double winRateWhileUsingRaid = 0.0;

  /// 取得レコード汎用機に登場した回数.
  int numberOfGeneralUses = 0;

  /// 汎用機に登場し、勝利した回数.
  int winNumWhileUsingGeneral = 0;

  /// 汎用機搭乗時の勝率.
  double winRateWhileUsingGeneral = 0.0;

  /// 取得レコード支援機に登場した回数.
  int numberOfSupportUses = 0;

  /// 支援機に登場し、勝利した回数.
  int winNumWhileUsingSupport = 0;

  /// 支援機搭乗時の勝率.
  double winRateWhileUsingSupport = 0.0;
}