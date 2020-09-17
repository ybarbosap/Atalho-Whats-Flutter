import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondPCubit extends Cubit<SecondState> {
  SecondPCubit() : super(SecondInitialState());

  void createLink(String phone){
    var valid = RegExp(r"(\(?\d{2}\)?\s)?(\d{4,5})\-?(\d{4})").hasMatch(phone);
    if(!valid){
      var error = "Telefone inválido, verifique o número fornecido";
      emit(SecondInvalidNumberState(error));
      return null;
    }
    var p = "+55$phone";
    var url = "https://api.whatsapp.com/send?phone=$p&text=";
    emit(SecondLinkState(url));
  }
}

class SecondState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SecondInitialState extends SecondState {}

class SecondLinkState extends SecondState {
  SecondLinkState(this.link);
  final String link;

  @override
  List<Object> get props => [link];
}

class SecondInvalidNumberState extends SecondState {
  SecondInvalidNumberState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}