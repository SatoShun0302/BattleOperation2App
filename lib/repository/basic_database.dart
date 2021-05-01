import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 各リポジトリーで拡張して使用するクラス
abstract class BasicDatabase {
  late Database _database;
  String get tableName;

  Future<Database> get database async {
      _database = await createDatabase();
    return _database;
  }

  /// DBがpathに存在しなかった場合に onCreateメソッドが呼ばれます
  createDatabase() async {
    final String directory = await getDatabasesPath();
    final String path = join(directory, DatabaseEnv.DBName);
    return await openDatabase(
        path,
        version: 1,
        onCreate: (_database, version) async {
          DatabaseUtil.createTable(_database, 1);
        }
    );
  }

  createTable(Database db, int version) async {}

  deleteMyDatabase() async {
    final String directory = await getDatabasesPath();
    final String path = join(directory, DatabaseEnv.DBName);
    await deleteDatabase(path);
  }
}