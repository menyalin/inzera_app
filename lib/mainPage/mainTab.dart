import 'package:flutter/cupertino.dart';

class MainPageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Главная страница'),
        ),
      ],
    );
  }
}
