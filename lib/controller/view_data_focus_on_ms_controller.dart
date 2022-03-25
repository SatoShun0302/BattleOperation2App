import 'package:battle_operation2_app/controller/common/mobile_suit_controller.dart';
import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/entity/map_list.dart';
import 'package:battle_operation2_app/entity/mobile_suit.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/repository/map_list_repository.dart';
import 'package:battle_operation2_app/repository/ms_list_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_data_view.dart';
import 'package:battle_operation2_app/service/battle_record_view/focus_on_map_view.dart';
import 'package:flutter/material.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class ViewDataFocusOnMsController extends GetxController {
  final MobileSuitController mobileSuitController = Get.find(tag: "mobileSuit");
  /// 一度検索したMSのデータを保持しておく.

  /// MSドロップダウンリスト
  List<DropdownMenuItem<Map<int, String>>> msDropdownList = [];

  RxInt chosenMsId = 0.obs;
  RxMap chosenMsMap = RxMap();

  final String searchHint = "機体名で検索ができます";

  /// 機体別データ画面の検索で使用する為のMS一覧を取得する.
  ///
  ///
  Future<List<DropdownMenuItem<Map<int, String>>>> getAllMobileSuit() async {
    List<MobileSuit> _list = await mobileSuitController.getAllMobileSuit();
    if (msDropdownList.isEmpty) {
      _list.asMap().forEach((index, ms) {
        Map<int, String> _map = new Map();
        _map[ms.id!] = "${ms.msName} Lv.${ms.msLevel}";
        msDropdownList.add(DropdownMenuItem(
          child: myText.Text(
            "${ms.msName ??= ""} Lv.${ms.msLevel}",
            style: TextStyle(fontSize: 15.0),
          ),
          value: _map,
        ));
      });
    }
    return msDropdownList;
  }
}