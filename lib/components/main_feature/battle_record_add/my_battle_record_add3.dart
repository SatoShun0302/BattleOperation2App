import 'package:battle_operation2_app/common_widget/cancel_button.dart';
import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/drawer_menu.dart';
import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_add/my_battle_record_add2.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/helper/list_util.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:flutter/cupertino.dart';

class MyBattleRecordAdd3 extends StatelessWidget {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final rateNumController = new TextEditingController();
    rateNumController.text = c.currentRateNum.value;
    return Scaffold(
      backgroundColor: ColorEnv.scaffoldBackground,
      appBar: AppBar(
        title: Text("試合結果入力"),
        backgroundColor: ColorEnv.appBarBackground,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: new DrawerMenu().expansionPanelList(),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Scrollbar(
        child: SingleChildScrollView(
          child: CustomContainer(
            widget: Column(
              children: <Widget>[
                HeadLine(
                    size: HeadLineSize.Medium,
                    text: "レート",
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenEnv.deviceWidth * 0.01,
                                right: ScreenEnv.deviceWidth * 0.02),
                            child: TextFormField(
                              controller: rateNumController,
                              maxLength: 4,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              autovalidateMode: AutovalidateMode.always,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "レートを入力してください";
                                }
                                // 数値変換可能な値かチェック
                                if (int.tryParse(value) == null) {
                                  return "数値を入力してください";
                                }
                              },
                              onChanged: (String value) {
                                // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                c.currentRateNum.value = value;
                                rateNumController.text = c.currentRateNum.value;
                              },
                            ),
                          ),
                        ),
                        // レート値１アップ
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  icon: FaIcon(FontAwesomeIcons.arrowCircleUp,
                                      color: Colors.blueAccent,
                                      size: ScreenEnv.deviceWidth * 0.08),
                                  splashRadius: ScreenEnv.deviceWidth * 0.07,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    if (c.currentRateNum.value.isNotEmpty) {
                                      int? rate =
                                          int.tryParse(c.currentRateNum.value);
                                      if (rate != null) {
                                        rate++;
                                        c.currentRateNum.value = "$rate";
                                        rateNumController.text =
                                            c.currentRateNum.value;
                                      }
                                    }
                                  },
                                ),
                              ),
                              // レート値１マイナス
                              Expanded(
                                child: IconButton(
                                  icon: FaIcon(FontAwesomeIcons.arrowCircleDown,
                                      color: Colors.blueAccent,
                                      size: ScreenEnv.deviceWidth * 0.08),
                                  splashRadius: ScreenEnv.deviceWidth * 0.07,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    if (c.currentRateNum.value.isNotEmpty) {
                                      int? rate =
                                          int.tryParse(c.currentRateNum.value);
                                      if (rate != null) {
                                        if (0 <
                                            int.tryParse(
                                                c.currentRateNum.value)!) {
                                          rate--;
                                          c.currentRateNum.value = "$rate";
                                          rateNumController.text =
                                              c.currentRateNum.value;
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HeadLine(
                    size: HeadLineSize.Medium,
                    text: "勝敗",
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Column(
                      children: <Widget>[
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "チーム",
                            showUnderLine: true),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: RadioListTile<int>(
                                  title: Text("勝利"),
                                  value: 1,
                                  groupValue: c.winOrLoseResultTeam.value,
                                  onChanged: (int? value) {
                                    c.winOrLoseResultTeam.value = value ??= -1;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<int>(
                                  title: Text("敗北"),
                                  value: 0,
                                  groupValue: c.winOrLoseResultTeam.value,
                                  onChanged: (int? value) {
                                    c.winOrLoseResultTeam.value = value ??= -1;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "ライバル",
                            showUnderLine: true),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: RadioListTile<int>(
                                  title: Text("勝利"),
                                  value: 1,
                                  groupValue: c.winOrLoseResultRival.value,
                                  onChanged: (int? value) {
                                    c.winOrLoseResultRival.value = value ??= -1;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<int>(
                                  title: Text("敗北"),
                                  value: 0,
                                  groupValue: c.winOrLoseResultRival.value,
                                  onChanged: (int? value) {
                                    c.winOrLoseResultRival.value = value ??= -1;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HeadLine(
                    size: HeadLineSize.Medium,
                    text: "戦績",
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Column(
                      children: <Widget>[
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "総合個人順位",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.1,
                                    left: ScreenEnv.deviceWidth * 0.1),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.overallRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.overallRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "個人スコア",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.personalScoreRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.personalScoreRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 5,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.personalScore.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.personalScore.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "アシストスコア",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.assistScoreRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.assistScoreRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 5,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.assistScore.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.assistScore.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "与ダメージ",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.dealDamageRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.dealDamageRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 6,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.dealDamage.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.dealDamage.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "陽動",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.feintRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.feintRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 6,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.feint.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (double.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (double.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.feint.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "MS撃破",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.msDefeatRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.msDefeatRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.msDefeat.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.msDefeat.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "MS損失",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.msLossRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.msLossRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.msLoss.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! < 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.msLoss.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeadLine(
                            size: HeadLineSize.Small,
                            text: "追撃アシスト",
                            showUnderLine: true),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 2,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.pursuitAssistRanking.value,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      } else {
                                        if (int.tryParse(value)! <= 0) {
                                          return "error";
                                        }
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.pursuitAssistRanking.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01,
                                    right: ScreenEnv.deviceWidth * 0.02,
                                    left: ScreenEnv.deviceWidth * 0.02),
                                child: Obx(
                                  () => TextFormField(
                                    maxLength: 6,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: c.pursuitAssist.value,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "";
                                      }
                                      // 数値変換可能な値かチェック
                                      if (int.tryParse(value) == null) {
                                        return "error";
                                      }
                                    },
                                    onChanged: (String value) {
                                      // 入力値が空でないかつ数値変換可能な場合のみ変数を更新
                                      c.pursuitAssist.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SubmitButton(
                    child: myText.Text(
                      "登録",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      List<String> validateResult = c.recordAdd3Validate();
                      if (validateResult.isNotEmpty) {
                        Get.snackbar(
                          "",
                          "",
                          titleText: myText.Text(
                            "エラー",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          messageText: myText.Text(
                            ListUtil.createSnackBarMessage(validateResult),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          isDismissible: true,
                          duration: Duration(
                              seconds:
                                  ListUtil.calcSnackBarDurationFromListLength(
                                      validateResult)),
                          backgroundColor: ColorEnv.snackBarBackground,
                        );
                      } else {
                        print("else");
                        //Get.off(() => MyBattleRecordAdd3());
                      }
                    }),
                CancelButton(
                  onPressed: () {
                    Get.off(() => MyBattleRecordAdd2());
                  },
                  child: myText.Text(
                    "前画面に戻る",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
