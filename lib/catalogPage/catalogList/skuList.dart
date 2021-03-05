import 'package:flutter/cupertino.dart';
import 'package:inzera_app2/appState.dart';
import 'package:inzera_app2/catalogPage/catalogList/catalogListItemCard.dart';
import 'package:inzera_app2/catalogPage/catalogList/searchField.dart';

import 'package:inzera_app2/models/catalogModel.dart';
import 'package:provider/provider.dart';

class SkuList extends StatelessWidget {
  final String parentName;
  final List<Catalog> skuList;
  SkuList(this.skuList, this.parentName);

  // Widget _itemBuilder(BuildContext context, int i) =>
  //     CatalogListItemCard(skuList[i], parentName);

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       SearchField(),
  //       Text('Hello'),
  //       ListView.builder(
  //         itemBuilder: _itemBuilder,
  //         itemCount: skuList.length,
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AppState>(
          builder: (_, appState, __) => SafeArea(
            bottom: false,
            child: parentName == 'Каталог'
                ? SearchField(appState.setSearchText)
                : Container(),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                top: false,
                bottom: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => CatalogListItemCard(skuList[i], parentName),
                    childCount: skuList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
