import 'package:battle_operation2_app/importer/dart_importer.dart';

class FocusOnMapWinRateChart {
  FocusOnMapWinRateChart(
      {required this.x,
      required this.y,
      required this.y2,
      required this.y3,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high});

  /// コスト.
  final dynamic x;

  /// MSタイプ別勝率.
  final num? y;

  /// MSタイプ別勝率.
  final num? y2;

  /// MSタイプ別勝率.
  final num? y3;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// MSタイプ名.
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;
}
