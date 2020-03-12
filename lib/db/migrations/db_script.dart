import 'init_db.dart';

class DbMigrator {
  static final Map<int, String> migration = {
    1: initDBScript,
  };
}