import 'package:flutter/cupertino.dart';
import 'package:inzera_app2/models/catalogModel.dart';

import '../../api.dart';
import 'catalogDetails.dart';
import 'catalogItemImage.dart';
import 'catalogMainInfoItem.dart';

class SkuInfo extends StatelessWidget {
  final String parentName;
  final Catalog catalog;
  SkuInfo(this.catalog, [this.parentName = '']);

  Widget _skuNameBuilder(Catalog catalog) {
    final _headerTextStyles =
        TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      child: Text(
        catalog.name,
        style: _headerTextStyles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        _skuNameBuilder(catalog),
        catalog.image != null
            ? CatalogItemImage(
                Api.imageCDNPath(catalog.image), catalog.price, catalog.name)
            : Container(),
        CatalogMainInfoItem(catalog, parentName),
        CatalogDetails(catalog),
      ],
    );
  }
}
