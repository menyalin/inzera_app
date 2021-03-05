import 'package:flutter/cupertino.dart';
import 'package:inzera_app2/catalogPage/catalogItem/skuInfo.dart';
import 'package:inzera_app2/models/catalogModel.dart';

class CatalogItemPage extends StatefulWidget {
  final String id;
  final String parentName;
  CatalogItemPage(this.id, [this.parentName = '']);

  @override
  _CatalogItemPageState createState() => _CatalogItemPageState();
}

class _CatalogItemPageState extends State<CatalogItemPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CatalogAPI.getCatalogById(id: widget.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = SkuInfo(snapshot.data, widget.parentName);
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
            middle: Text(widget.parentName ?? '_'),
          ),
          child: children,
        );
      },
    );
  }
}
