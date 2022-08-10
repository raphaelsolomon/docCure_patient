
import 'package:doccure_patient/model/log.dart';
import 'package:doccure_patient/utils/hive_method.dart';

class LogRepository {
  // ignore: prefer_typing_uninitialized_variables
  static var dbObject;
  static bool isHive = true;

  static init({required bool isHive, required String dbName}) {
    dbObject = isHive ? HiveMethods() : null;
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static getLogs() => dbObject.getLogs();

  static close() => dbObject.close();
}