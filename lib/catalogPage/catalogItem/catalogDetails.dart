import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:inzera_app2/models/catalogModel.dart';

class CatalogDetails extends StatefulWidget {
  final Catalog catalog;
  CatalogDetails(this.catalog);
  @override
  _CatalogDetailsInfoState createState() => _CatalogDetailsInfoState();
}

class _CatalogDetailsInfoState extends State<CatalogDetails> {
  List<Detail> _data = [];

  @override
  void initState() {
    _data = generateList(widget.catalog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _data.map((detail) => _detailCardBuilder(detail)).toList(),
    );
  }
}

Widget _detailCardBuilder(Detail detail) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            detail.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(detail.description),
      ],
    ),
  );
}

List<Detail> generateList(Catalog sku) {
  List<Detail> tpmItems = [];
  if (sku.brand is Detail) {
    tpmItems.add(sku.brand);
  }
  if (sku.company is Detail) {
    tpmItems.add(sku.company);
  }
  if (sku.recomendation is Detail) {
    tpmItems.add(sku.recomendation);
  }
  if (sku.sommelier is Detail) {
    tpmItems.add(sku.sommelier);
  }

  return tpmItems.length > 0 ? tpmItems : null;
}
