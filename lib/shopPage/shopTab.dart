import 'package:flutter/cupertino.dart';

class ShopPageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Магазины'),
        ),
      ],
    );
  }
}
