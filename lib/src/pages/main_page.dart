import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:shortcut_whats/src/pages/first/first_page.dart';
import 'package:shortcut_whats/src/pages/second/second_page.dart';
import 'package:shortcut_whats/src/utils/admob_utils.dart';
import 'package:shortcut_whats/src/utils/colors_utils.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>["B861C85D065DEEFBF7D9F2EF73F8E9B8"], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
    adUnitId: AdmobUtils.bannerId,
  );

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: AdmobUtils.appId).then((value) {
      myBanner
        ..load()
        ..show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Atalho Whats"),
      bottom: TabBar(
        tabs: [
          Tab(child: Text("INICIAR CONVERSA")),
          Tab(child: Text("GERAR LINK"))
        ],
        indicatorColor: ColorsUtils.backgroundButton,
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: [FirstPage(), SecondPage()],
        ),
      ),
    );
  }
}
