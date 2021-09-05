
/// データベースの環境変数・定数
class DatabaseEnv {

 static const String DBName = "gbo_app.db";
 static const String stageTable = "stage_list_table";
 static const String msListTable = "ms_list_table";
 static const String generalMsTable = "general_ms_list_table";
 static const String supportMsTable = "support_ms_list_table";
 static const String raidMsTable = "raid_ms_list_table";
 static const String recordTable = "record_table";
 static const String msTypeTable = "ms_type_table";
 static const String costTable = "cost_table";
 /// 削除済みフラグTrue
 static const int isDeletedTrue = 1;
 /// 削除済みフラグFalse
 static const int isDeletedFalse = 0;

 void test() {

 }
}