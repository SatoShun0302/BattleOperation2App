
/// データベースの環境変数・定数
class DatabaseEnv {

 static const String DBName = "gbo_app.db";
 static const String stageTable = "stage_list";
 static const String msListTable = "mobile_suit";
 static const String generalMsTable = "general_ms";
 static const String supportMsTable = "support_ms";
 static const String raidMsTable = "raid_ms";
 static const String msTypeTable = "ms_type";
 static const String costTable = "cost";
 static const String battleRecordTable = "battle_record";
 static const String battleRecordWingmanTable = "battle_record_wingman";
 /// 削除済みフラグTrue
 static const int isDeletedTrue = 1;
 /// 削除済みフラグFalse
 static const int isDeletedFalse = 0;

 void test() {

 }
}