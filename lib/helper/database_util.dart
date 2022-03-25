import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// データベースの作成時などに使うメソッドを扱うクラス
class DatabaseUtil {
  static createTable(Database? db, int version) {
    // ステージ一覧テーブル
    db!.execute("""
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
      """);
    // MSテーブル
    db.execute("""
      CREATE TABLE ${DatabaseEnv.msListTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_name TEXT NOT NULL,
      ms_level INTEGER NOT NULL,
      ms_type INTEGER NOT NULL,
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
      """);
    // 汎用MSテーブル
    // db.execute("""
    //   CREATE TABLE ${DatabaseEnv.generalMsTable}(
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   ms_name TEXT NOT NULL,
    //   ms_level INTEGER NOT NULL,
    //   ms_type TEXT NOT NULL,
    //   can_ground INTEGER NOT NULL,
    //   can_space INTEGER NOT NULL,
    //   cost INTEGER NOT NULL,
    //   official_pic_url TEXT,
    //   wiki_pic_url TEXT,
    //   wiki_page_url TEXT,
    //   is_favorite INTEGER,
    //   is_deleted INTEGER NOT NULL,
    //   UNIQUE(id),
    //   UNIQUE(ms_name, ms_level)
    //   )
    //   """);
    // 支援MSテーブル
    // db.execute("""
    //   CREATE TABLE ${DatabaseEnv.supportMsTable}(
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   ms_name TEXT NOT NULL,
    //   ms_level INTEGER NOT NULL,
    //   ms_type TEXT NOT NULL,
    //   can_ground INTEGER NOT NULL,
    //   can_space INTEGER NOT NULL,
    //   cost INTEGER NOT NULL,
    //   official_pic_url TEXT,
    //   wiki_pic_url TEXT,
    //   wiki_page_url TEXT,
    //   is_favorite INTEGER,
    //   is_deleted INTEGER NOT NULL,
    //   UNIQUE(id),
    //   UNIQUE(ms_name, ms_level)
    //   )
    //   """);
    // 強襲MSテーブル
    // db.execute("""
    //   CREATE TABLE ${DatabaseEnv.raidMsTable}(
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   ms_name TEXT NOT NULL,
    //   ms_level INTEGER NOT NULL,
    //   ms_type TEXT NOT NULL,
    //   can_ground INTEGER NOT NULL,
    //   can_space INTEGER NOT NULL,
    //   cost INTEGER NOT NULL,
    //   official_pic_url TEXT,
    //   wiki_pic_url TEXT,
    //   wiki_page_url TEXT,
    //   is_favorite INTEGER,
    //   is_deleted INTEGER NOT NULL,
    //   UNIQUE(id),
    //   UNIQUE(ms_name, ms_level)
    //   )
    //   """);
    // MSタイプテーブル
    db.execute("""
      CREATE TABLE ${DatabaseEnv.msTypeTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_type_name TEXT NOT NULL,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(ms_type_name)
      )
      """);
    // コスト一覧テーブル
    db.execute("""
      CREATE TABLE ${DatabaseEnv.costTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      cost INTEGER NOT NULL,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(cost)
      )
      """);
    // 戦績テーブル
    db.execute("""
      CREATE TABLE ${DatabaseEnv.battleRecordTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ms_id INTEGER NOT NULL,
      ms_type_id INTEGER NOT NULL,
      map_id INTEGER NOT NULL,
      cost INTEGER NOT NULL,
      number_of_player INTEGER NOT NULL,
      side TEXT NOT NULL,
      formation INTEGER NOT NULL,
      not_highest_rank_player INTEGER NOT NULL,
      win_or_lose_prediction INTEGER NOT NULL,
      win_or_lose INTEGER NOT NULL,
      is_blast_base INTEGER NOT NULL,
      rival_win_or_lose_result INTEGER NOT NULL,
      overall_ranking INTEGER NOT NULL,
      personal_score_ranking INTEGER NOT NULL,
      personal_score INTEGER NOT NULL,
      assist_score_ranking INTEGER NOT NULL,
      assist_score INTEGER NOT NULL,
      deal_damage_ranking INTEGER NOT NULL,
      deal_damage INTEGER NOT NULL,
      feint_ranking INTEGER NOT NULL,
      feint REAL NOT NULL,
      ms_defeat_ranking INTEGER NOT NULL,
      ms_defeat INTEGER NOT NULL,
      ms_loss_ranking INTEGER NOT NULL,
      ms_loss INTEGER NOT NULL,
      pursuit_assist_ranking INTEGER NOT NULL,
      pursuit_assist INTEGER NOT NULL,
      rate_result INTEGER NOT NULL,
      rate_rise_and_fall INTEGER NOT NULL,
      time_frame INTEGER NOT NULL,
      weekdays INTEGER NOT NULL,
      insert_date_unix INTEGER NOT NULL,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id),
      UNIQUE(insert_date_unix)
      )
      """);
    // 戦績テーブル 僚機
    db.execute("""
      CREATE TABLE ${DatabaseEnv.battleRecordWingmanTable}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      battle_record_id  INTEGER NOT NULL,
      ms_id INTEGER NOT NULL,
      is_deleted INTEGER NOT NULL,
      UNIQUE(id)
      )
      """);
    //db.execute("sql");
  }
}
