import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 時間帯別勝率をもとにラインチャートを描画する際に使用するモデルクラス.
class TimeFrameWinRateChart {
  TimeFrameWinRateChart(this.x, this.y, [this.lineColor]);
  final int x;
  final int y;
  final Color? lineColor;
}