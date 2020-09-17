import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database/sqflite_impl.dart';
import '../../utils/colors_utils.dart';
import '../../utils/routeUtils.dart';
import 'cubit/first_page_cubit.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => FirstPCubit(DataBaseService()),
      child: FirstPageView(),
    );
  }
}

class FirstPageView extends StatefulWidget {
  @override
  _FirstPageViewState createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height - (56 + 56),
        child: ListView(
          children: [
            Container(
              // appbar - tabbar - card padding
              height: size.height - (56 + 56 + 56 + 16),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _card(),
                ),
              ),
            ),
            const SizedBox(height: 56)
          ],
        ),
      ),
    );
  }

  Widget _card() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Align(
                      child: const Text(
                        "+55",
                        style: TextStyle(
                            fontSize: 16, color: ColorsUtils.secondText),
                      ),
                      alignment: Alignment.bottomCenter),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Ex.: (00) 00000-0000 ", hintMaxLines: 1),
                      controller: _phone,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: ColorsUtils.secondText, fontSize: 16),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteUtils.history);
                  },
                  padding: EdgeInsets.zero,
                  textColor: ColorsUtils.backgroundButton,
                  child: const Text("USAR HISTÓRICO"),
                ),
              ),
              RaisedButton(
                child: const Text(
                  "INICIAR CONVERSA",
                  style: TextStyle(color: ColorsUtils.primaryText),
                ),
                onPressed: () {
                  var phone = _phone.text.toString();
                  print(phone);
                  context
                      .bloc<FirstPCubit>()
                      .openWhats(phone)
                      .then((value) => _phone.clear());
                },
              ),
              BlocBuilder<FirstPCubit, FirstPState>(
                builder: (_, state) {
                  if (state is FirstPFailLaunch)
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          state.msg,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    );
                  return Container();
                },
              ),
            ],
          ),
        ),
      );
}
