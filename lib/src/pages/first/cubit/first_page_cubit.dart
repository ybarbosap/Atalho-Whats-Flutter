import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortcut_whats/src/services/database/interface.dart';
import 'package:shortcut_whats/src/services/database/sqflite_impl.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPCubit extends Cubit<FirstPState> {
  FirstPCubit(this._db) : super(FirstPInitial());

  final IDataBase _db;

  Future<void> openWhats(String phone) async {
    if(phone != ""){
      var url = "whatsapp://send?phone=+55$phone";
      var id = _db.create("+55$phone");
      await canLaunch(url)
          ? launch(url).then((value) => emit(FirstPInitial()))
          : emit(
              FirstPFailLaunch("Verifique se você tem o Whatsapp instalado"));
    }
  }
}

class FirstPState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FirstPInitial extends FirstPState {}

class FirstPFailLaunch extends FirstPState {
  FirstPFailLaunch(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
