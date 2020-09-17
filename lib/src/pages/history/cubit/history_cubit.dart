import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortcut_whats/src/models/history_model.dart';
import 'package:shortcut_whats/src/services/database/interface.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryCubit extends Cubit<HistorySate> {
  HistoryCubit(this._db) : super(HistoryInitialState());
  final IDataBase _db;

  Future<void> getHistory() async {
    emit(HistoryLoadingState());
    var models = await _db.getHistory();
    await Future.delayed(const Duration(seconds: 1));
    if(models.length > 0)
      emit(HistoryDataState(models));
    else
      emit(HistoryInitialState());
  }

  Future<void> clearHistory()async{
    await _db.clear();
    emit(HistoryInitialState());
  }

  Future<void> dellItem(int id)async{
    await _db.dell(id);
    var models = await _db.getHistory();
    if(models.length > 0)
      emit(HistoryDataState(models));
    else
      emit(HistoryInitialState());
  }

  Future<void> openWhats(String phone) async {
    var url = "whatsapp://send?phone=$phone";
    if (await canLaunch(url)) launch(url);
  }
}

class HistorySate extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoryInitialState extends HistorySate {
  @override
  List<Object> get props => [];
}

class HistoryLoadingState extends HistorySate {
  @override
  List<Object> get props => [];
}

class HistoryDataState extends HistorySate {
  HistoryDataState(this.models);

  final List<HistoryModel> models;

  @override
  List<Object> get props => [models];
}
