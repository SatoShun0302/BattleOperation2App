import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/weekdays_win_rate_chart.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class WinRateColumnChart extends StatefulWidget {
  const WinRateColumnChart({Key? key, required this.listData}) : super(key: key);

  final listData;

  @override
  _WinRateColumnChartState createState() => _WinRateColumnChartState(listData);
}

class _WinRateColumnChartState extends State<WinRateColumnChart> {
  _WinRateColumnChartState(this.listData);

  late TooltipBehavior _tooltipBehavior;
  final listData;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white10,
      child: _buildDefaultColumnChart(),
    );
  }

  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(
            color: Colors.white
        ),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}%',
          labelStyle: TextStyle(
            color: Colors.white
          ),
          majorTickLines: const MajorTickLines(size: 0)),
      tooltipBehavior: _tooltipBehavior,
      series: <ColumnSeries<WeekdaysWinRateChart, String>>[
        ColumnSeries<WeekdaysWinRateChart, String>(
          dataSource: listData,
          xValueMapper: (WeekdaysWinRateChart data, _) => data.x as String,
          yValueMapper: (WeekdaysWinRateChart data, _) => data.y,
        pointColorMapper: (WeekdaysWinRateChart data, _) => data.pointColor,
        dataLabelSettings: const DataLabelSettings(
              isVisible: true, textStyle: TextStyle(fontSize: 10, color: Colors.white)),
        )
      ],

    );
  }
}
