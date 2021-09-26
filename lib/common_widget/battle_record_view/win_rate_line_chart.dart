import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/time_frame_win_rate_chart.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class WinRateLineChart extends StatefulWidget {
  const WinRateLineChart(
      {Key? key, required List<TimeFrameWinRateChart> this.listData})
      : super(key: key);

  final listData;

  @override
  _WinRateLineChartState createState() => _WinRateLineChartState(listData);
}

class _WinRateLineChartState extends State<WinRateLineChart> {
  _WinRateLineChartState(this.listData);

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
      child: _buildMultiColorLineChart(),
    );
  }

  // lineChartを取得.
  SfCartesianChart _buildMultiColorLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        minimum: 0,
        maximum: 23,
        interval: 2,
        labelStyle: TextStyle(
            color: Colors.white
        ),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          interval: 10,
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}%',
          labelStyle: TextStyle(
              color: Colors.white
          ),
          majorTickLines: const MajorTickLines(size: 0)),
      series: <LineSeries<TimeFrameWinRateChart, int>>[
        LineSeries<TimeFrameWinRateChart, int>(
            animationDuration: 1500,
            dataSource: listData,
            xValueMapper: (TimeFrameWinRateChart data, _) => data.x,
            yValueMapper: (TimeFrameWinRateChart data, _) => data.y,

            /// The property used to apply the color each data.
            pointColorMapper: (TimeFrameWinRateChart data, _) =>
            data.lineColor,
            width: 3)
      ],
      trackballBehavior: _trackballBehavior,
    );
  }
}
