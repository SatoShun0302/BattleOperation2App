import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';

enum HeadLineSize { Small, Medium, Large }

class HeadLine extends StatelessWidget {
  /// 汎用見出し.
  ///
  /// HeadLineSize size: enum HeadLineSizeより選択,
  /// Widget? icon: 見出しの左に配置するアイコン,
  /// double? containerPadding: Containerのpadding,
  /// Color? textColor: 見出し文字の色,
  /// FontWeight fontWeight = FontWeight.normal FontWeight.w100” ~ “FontWeight.w900
  /// double? letterSpacing: 見出し文字間のスペース
  HeadLine({
    Key? key,
    HeadLineSize this.size = HeadLineSize.Medium,
    required String this.text,
    Widget? this.icon,
    double? this.containerPadding,
    Color this.textColor = Colors.black,
    FontWeight this.fontWeight = FontWeight.normal,
    double this.letterSpacing = 0.0,
    bool this.showUnderLine = false,
    Color this.underLineColor = Colors.black,
  }) : super(key: key);
  final size;
  final text;
  final icon;
  final containerPadding;
  final textColor;
  final fontWeight;
  final letterSpacing;
  final showUnderLine;
  final underLineColor;

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case HeadLineSize.Small:
        return Row(
          children: [
            if (icon != null) icon,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: ScreenEnv.deviceWidth * 0.02, left: ScreenEnv.deviceWidth * 0.02),
                padding: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.01),
                decoration: showUnderLine ? BoxDecoration(
                  border: Border( bottom: BorderSide(color: underLineColor, width: ScreenEnv.deviceWidth * 0.003)),
                ) : null,
                child: myText.Text(
                  text,
                  style: TextStyle(
                      fontSize: ScreenEnv.deviceWidth * 0.04,
                      color: textColor,
                      fontWeight: fontWeight,
                      letterSpacing: letterSpacing),
                ),
              ),
            ),
          ],
        );
      case HeadLineSize.Medium:
        return Row(
          children: [
            if (icon != null) icon,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: ScreenEnv.deviceWidth * 0.02, left: ScreenEnv.deviceWidth * 0.02),
                padding: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.01),
                decoration: showUnderLine ? BoxDecoration(
                  border: Border( bottom: BorderSide(color: underLineColor, width: ScreenEnv.deviceWidth * 0.006)),
                ) : null,
                child: myText.Text(
                  text,
                  style: TextStyle(
                      fontSize: ScreenEnv.deviceWidth * 0.055,
                      color: textColor,
                      fontWeight: fontWeight,
                      letterSpacing: letterSpacing),
                ),
              ),
            ),
          ],
        );
      case HeadLineSize.Large:
        return Container(
          child: Row(
            children: [
              if (icon != null) icon,
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: ScreenEnv.deviceWidth * 0.02, left: ScreenEnv.deviceWidth * 0.02),
                  padding: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.01),
                  decoration: showUnderLine ? BoxDecoration(
                    border: Border( bottom: BorderSide(color: underLineColor, width: ScreenEnv.deviceWidth * 0.01)),
                  ) : null,

                  child: myText.Text(
                    text,
                    style: TextStyle(
                        fontSize: ScreenEnv.deviceWidth * 0.085,
                        color: textColor,
                        fontWeight: fontWeight,
                        letterSpacing: letterSpacing),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return Row(
          children: [
            if (icon != null) icon,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: ScreenEnv.deviceWidth * 0.02, left: ScreenEnv.deviceWidth * 0.02),
                decoration: showUnderLine ? BoxDecoration(
                  border: Border( bottom: BorderSide(color: underLineColor, width: ScreenEnv.deviceWidth * 0.005)),
                ) : null,
                child: myText.Text(
                  text,
                  style: TextStyle(
                      fontSize: ScreenEnv.deviceWidth * 0.05,
                      color: textColor,
                      fontWeight: fontWeight,
                      letterSpacing: letterSpacing),
                ),
              ),
            ),
          ],
        );
    }
  }
}
