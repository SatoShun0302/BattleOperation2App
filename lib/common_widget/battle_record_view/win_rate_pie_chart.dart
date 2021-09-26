import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class WinRatePieChart extends StatefulWidget {
  const WinRatePieChart(
      {Key? key,
      required String this.title,
      required List<MobileSuitTypeWinRateChart> this.listData})
      : super(key: key);

  final title;
  final listData;

  @override
  _WinRatePieChartState createState() => _WinRatePieChartState(title, listData);
}

class _WinRatePieChartState extends State<WinRatePieChart> {
  _WinRatePieChartState(
      String this.title, List<MobileSuitTypeWinRateChart> this.listData)
      : super();

  late SelectionBehavior selectionBehavior;
  bool enableMultiSelect = false;
  bool _toggleSelection = true;
  final title;
  final listData;

  @override
  Widget build(BuildContext context) {
    selectionBehavior =
        SelectionBehavior(enable: true, toggleSelection: _toggleSelection);
    return Card(
      elevation: 5,
      color: Colors.white10,
      child: _buildCircularSelectionChart(),
    );
  }

  SfCircularChart _buildCircularSelectionChart() {
    return SfCircularChart(
      selectionGesture: ActivationMode.singleTap,
      enableMultiSelection: enableMultiSelect,
      borderColor: Colors.cyanAccent,
      series: <PieSeries<MobileSuitTypeWinRateChart, String>>[
        PieSeries<MobileSuitTypeWinRateChart, String>(
            dataSource: listData,
            radius: '55%',
            explodeOffset: '1%',
            startAngle: 0,
            endAngle: 0,
            pointColorMapper: (MobileSuitTypeWinRateChart data, _) => data.pointColor,
            xValueMapper: (MobileSuitTypeWinRateChart data, _) =>
            data.x as String,
            yValueMapper: (MobileSuitTypeWinRateChart data, _) =>
            data.y,
            dataLabelMapper: (MobileSuitTypeWinRateChart data, _) =>
            data.text,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(fontSize: ScreenEnv.deviceWidth * 0.03,
                color: Colors.white)
            ),

            /// To enable the selection settings and its functionalities.
            selectionBehavior: selectionBehavior)
      ],
    );
  }
}
