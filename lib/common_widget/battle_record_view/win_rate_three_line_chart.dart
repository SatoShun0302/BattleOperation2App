import 'package:battle_operation2_app/chart_model/focus_on_map_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/time_frame_win_rate_chart.dart';
import 'package:battle_operation2_app/config/enums.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/helper/enum_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class WinRateThreeLineChart extends StatefulWidget {
  const WinRateThreeLineChart({Key? key, required this.listData}) : super(key: key);

  final listData;

  @override
  _WinRateThreeLineChartState createState() => _WinRateThreeLineChartState(listData);
}

class _WinRateThreeLineChartState extends State<WinRateThreeLineChart> {
  _WinRateThreeLineChartState(this.listData);

  late TrackballBehavior _trackballBehavior;
  final listData;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(enable: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white10,
      child: _buildDefaultLineChart(),
    );
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
          interval: 100,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          maximum: 100,
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      trackballBehavior: _trackballBehavior,
      tooltipBehavior: TooltipBehavior(enable: true),
      onTrackballPositionChanging: (args) {
        args.chartPointInfo.label =
        '《${EnumUtil.getMobileSuitType(EnumUtil.getMobileSuitTypeByNum(args.chartPointInfo.seriesIndex + 1)!)}》勝率:${(args.chartPointInfo.chartDataPoint?.y).floor()}%'
            ' コスト:${args.chartPointInfo.chartDataPoint?.x}';
      },
      series: <LineSeries<FocusOnMapWinRateChart, num>>[
        LineSeries<FocusOnMapWinRateChart, num>(
            animationDuration: 1500,
            dataSource: listData,
            xValueMapper: (FocusOnMapWinRateChart data, _) => data.x,
            yValueMapper: (FocusOnMapWinRateChart data, _) => data.y,
            width: 3,
            color: Colors.red,
            name: EnumUtil.getMobileSuitType(MobileSuitType.Raid),
            markerSettings: const MarkerSettings(isVisible: true)),
        LineSeries<FocusOnMapWinRateChart, num>(
            animationDuration: 1500,
            dataSource: listData,
            xValueMapper: (FocusOnMapWinRateChart data, _) => data.x,
            yValueMapper: (FocusOnMapWinRateChart data, _) => data.y2,
            width: 3,
            color: Colors.blue,
            name: EnumUtil.getMobileSuitType(MobileSuitType.General),
            markerSettings: const MarkerSettings(isVisible: true)),
        LineSeries<FocusOnMapWinRateChart, num>(
            animationDuration: 1500,
            dataSource: listData,
            width: 3,
            color: Colors.yellow,
            name: EnumUtil.getMobileSuitType(MobileSuitType.Support),
            xValueMapper: (FocusOnMapWinRateChart data, _) => data.x,
            yValueMapper: (FocusOnMapWinRateChart data, _) => data.y3,
            markerSettings: const MarkerSettings(isVisible: true))
      ],
    );
  }
}
