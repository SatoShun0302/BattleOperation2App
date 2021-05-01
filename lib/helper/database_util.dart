import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// データベースの作成時などに使うメソッドを扱うクラス
class DatabaseUtil {

  static createTable(Database? db, int version) {
    db!.execute(
      """
      CREATE TABLE ${DatabaseEnv.stageTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      map_id INTEGER NOT NULL,
      map_name TEXT NOT NULL,
      official_pic_url TEXT,
      wiki_pic_url TEXT,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(map_id)
      )
      """,
    );
    db.execute(
      """
      CREATE TABLE ${DatabaseEnv.generalMsTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_name TEXT NOT NULL,
      ms_level INTEGER NOT NULL,
      ms_type TEXT NOT NULL,
      can_ground INTEGER NOT NULL,
      can_space INTEGER NOT NULL,
      cost INTEGER NOT NULL,
      official_pic_url TEXT,
      wiki_pic_url TEXT,
      wiki_page_url TEXT,
      is_favorite INTEGER,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(ms_name, ms_level)
      )
      """
    );
    db.execute(
        """
      CREATE TABLE ${DatabaseEnv.supportMsTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_name TEXT NOT NULL,
      ms_level INTEGER NOT NULL,
      ms_type TEXT NOT NULL,
      can_ground INTEGER NOT NULL,
      can_space INTEGER NOT NULL,
      cost INTEGER NOT NULL,
      official_pic_url TEXT,
      wiki_pic_url TEXT,
      wiki_page_url TEXT,
      is_favorite INTEGER,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(ms_name, ms_level)
      )
      """
    );
    db.execute(
        """
      CREATE TABLE ${DatabaseEnv.raidMsTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_name TEXT NOT NULL,
      ms_level INTEGER NOT NULL,
      ms_type TEXT NOT NULL,
      can_ground INTEGER NOT NULL,
      can_space INTEGER NOT NULL,
      cost INTEGER NOT NULL,
      official_pic_url TEXT,
      wiki_pic_url TEXT,
      wiki_page_url TEXT,
      is_favorite INTEGER,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(ms_name, ms_level)
      )
      """
    );
    //db.execute("sql");
    //db.execute("sql");
  }
}
