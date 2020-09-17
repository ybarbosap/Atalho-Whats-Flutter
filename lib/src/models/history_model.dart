class HistoryModel {
  HistoryModel({this.id, this.phone});

  int id;
  String phone;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        phone: json["phone"],
      );
}
