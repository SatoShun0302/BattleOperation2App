import 'package:battle_operation2_app/importer/dart_importer.dart';

class MsTypeList {
  @required
  int id;

  @required
  String msTypeName;

  @required
  int isDelete;

  // コンストラクタ.
  MsTypeList(this.id, this.msTypeName, this.isDelete);

  /// MsTypeListをマップで返す.
  Map<String, dynamic> toMap() => {
    "id": id,
    "msTypeName": msTypeName
  };
}
