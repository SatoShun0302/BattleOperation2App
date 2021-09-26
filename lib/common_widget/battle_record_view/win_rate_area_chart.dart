import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/not_highest_rank_player_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/weekdays_win_rate_chart.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class WinRateAreaChart extends StatefulWidget {
  const WinRateAreaChart({Key? key, required this.listData}) : super(key: key);
  final listData;

  @override
  _WinRateAreaChartState createState() => _WinRateAreaChartState(listData);
}

class _WinRateAreaChartState extends State<WinRateAreaChart> {
  _WinRateAreaChartState(this.listData);

  late TrackballBehavior _trackballBehavior;
  final listData;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white10,
      child: _buildDefaultAreaChart(),
    );
  }

  SfCartesianChart _buildDefaultAreaChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
          interval: 1,
          labelStyle: TextStyle(
              color: Colors.white
          ),
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          labelStyle: TextStyle(
              color: Colors.white
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      tooltipBehavior: TooltipBehavior(enable: true),
      trackballBehavior: _trackballBehavior,
      series: <AreaSeries<NotHighestRankPlayerWinRateChart, int>>[
        AreaSeries<NotHighestRankPlayerWinRateChart, int>(
          dataSource: listData,
          opacity: 0.6,
          color: Colors.green,
          name: '人数: 勝率',
          xValueMapper: (NotHighestRankPlayerWinRateChart data, _) => data.x,
          yValueMapper: (NotHighestRankPlayerWinRateChart data, _) => data.y,
        ),
      ],
    );
  }
}
