import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortcut_whats/src/pages/history/cubit/history_cubit.dart';
import 'package:shortcut_whats/src/pages/history/widgets/history_item.dart';
import 'package:shortcut_whats/src/services/database/sqflite_impl.dart';
import 'package:shortcut_whats/src/utils/colors_utils.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryCubit>(
      create: (_) => HistoryCubit(DataBaseService())..getHistory(),
      child: HistoryPageView(),
    );
  }
}

class HistoryPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = context.bloc<HistoryCubit>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HISTÓRICO"),
      ),
      body: BlocBuilder<HistoryCubit, HistorySate>(
        builder: (ctx, state) {
          if (state is HistoryInitialState) {
            return _initialStateWidget(size);
          } else if (state is HistoryDataState) {
            return _dataStateWidget(context, state, cubit);
          } else if (state is HistoryLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(ColorsUtils.backgroundButton),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<void> clearAlert(BuildContext context) async {
    var alert = AlertDialog(
      title: const Text("Deletar histórico?"),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("NÃO"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            context.bloc<HistoryCubit>().clearHistory();
          },
          child: const Text("SIM"),
        )
      ],
    );

    await showDialog(context: context, builder: (_) => alert);
  }

  Widget _initialStateWidget(Size size) => SizedBox.fromSize(
        size: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/empty.png",
              fit: BoxFit.cover,
              width: size.width * .3,
            ),
            const Text(
              "NENHUM REGISTRO",
              style: const TextStyle(
                  fontSize: 20,
                  color: ColorsUtils.secondText,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      );

  Widget _dataStateWidget(
          BuildContext context, HistoryDataState state, HistoryCubit cubit) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FlatButton(
                onPressed: () => clearAlert(context),
                child: const Text(
                  "LIMPAR HISTÓRICO",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const Divider(),
            for (var model in state.models)
              HistoryItem(model, cubit.openWhats, cubit.dellItem)
          ],
        ),
      );
}
