import 'package:flutter/material.dart';
import 'package:shortcut_whats/src/models/history_model.dart';
import 'package:shortcut_whats/src/utils/colors_utils.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem(this.model, this.openCallback, this.clearCallback);

  final HistoryModel model;
  final Function(String phone) openCallback;
  final Function(int id) clearCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(model.phone, style: TextStyle(
            color: ColorsUtils.secondText,
            fontSize: 16
          ),),
        ),
        IconButton(
          icon: Icon(Icons.open_in_new),
          color: ColorsUtils.backgroundButton,
          onPressed: () => openCallback(model.phone),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          color: Colors.redAccent,
          onPressed: () => clearCallback(model.id),
        ),
      ],
    );
  }
}
