import 'package:shortcut_whats/src/models/history_model.dart';

abstract class IDataBase {

  Future<int> create(String phone);
  Future<int> dell(int id);
  Future<void> clear();
  Future<List<HistoryModel>> getHistory();

}