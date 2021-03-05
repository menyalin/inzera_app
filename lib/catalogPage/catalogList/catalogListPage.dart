import 'package:flutter/cupertino.dart';

import 'package:inzera_app2/catalogPage/catalogList/skuList.dart';
import 'package:inzera_app2/models/catalogModel.dart';
import 'package:inzera_app2/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../appState.dart';

class CatalogListPage extends StatelessWidget {
  final String parent;
  final String pageTitle;
  CatalogListPage([this.parent, this.pageTitle = 'Каталог']);

  Map<String, String> queryParamsBuilder({String parent, String search}) {
    Map<String, String> params = {
      'date': currentDateString(),
    };
    if (search.length > 3) {
      params['search'] = search;
    } else {
      params['parent'] = parent ?? 'root';
    }
    return params;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appState, __) => FutureBuilder(
        future: CatalogAPI.getCatalogGroup(queryParamsBuilder(
          parent: parent,
          search: appState.searchText,
        )),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = SkuList(
              snapshot.data,
              pageTitle,
            );
          } else if (snapshot.hasError) {
            children = Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            children = Center(
              child: CupertinoActivityIndicator(
                radius: 30,
              ),
            );
          }
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(pageTitle),
            ),
            child: children,
          );
        },
      ),
    );
  }
}
