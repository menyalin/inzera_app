import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inzera_app2/catalogPage/catalogList/catalogListPage.dart';

import 'appTheme.dart';
import 'mainPage/mainTab.dart';
import 'shopPage/shopTab.dart';

class InzeraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Inzera',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: InzeraHomePage(),
      ),
    );
  }
}

class InzeraHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Theme.of(context).iconTheme.color,
        iconSize: Theme.of(context).iconTheme.size,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Магазины',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MainPageTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(
              builder: (context) => CatalogListPage(),
            );
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShopPageTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
