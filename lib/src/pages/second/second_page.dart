import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

import '../../utils/colors_utils.dart';
import 'cubit/second_page_cubit.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecondPCubit(),
      child: SecondPageView(),
    );
  }
}

class SecondPageView extends StatelessWidget {
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
                  child: _card(context),
                ),
              ),
            ),
            const SizedBox(height: 56)
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context) => Card(
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
              const SizedBox(height: 16),
              RaisedButton(
                child: const Text(
                  "GERAR LINK",
                  style: TextStyle(color: ColorsUtils.primaryText),
                ),
                onPressed: () {
                  var phone = _phone.text.toString();
                  context.bloc<SecondPCubit>().createLink(phone);
                },
              ),
              BlocBuilder<SecondPCubit, SecondState>(
                builder: (_, state) {
                  if (state is SecondLinkState)
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.link,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Share.share(state.link);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: ColorsUtils.backgroundButton,
                                ),
                              ),
                              const Text("SHARE")
                            ],
                          )
                        ],
                      ),
                    );
                  if (state is SecondInvalidNumberState)
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          state.error,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
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
