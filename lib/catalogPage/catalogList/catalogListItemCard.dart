import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzera_app2/catalogPage/catalogItem/catalogItemPage.dart';
import 'package:inzera_app2/catalogPage/catalogList/catalogListPage.dart';
import 'package:inzera_app2/common/discountLabel.dart';
import 'package:inzera_app2/models/catalogModel.dart';
import 'package:inzera_app2/utils/helpers.dart';

import '../../api.dart';

class CatalogListItemCard extends StatelessWidget {
  final String parentName;
  final Catalog catalog;
  CatalogListItemCard(this.catalog, this.parentName);

  @override
  Widget build(BuildContext context) {
    return catalog.type == 'group'
        ? _GroupItem(catalog)
        : _SkuItem(catalog, parentName);
  }
}

class _GroupItem extends StatelessWidget {
  final Catalog group;
  _GroupItem(this.group);

  Widget _svgImageGroupBuilder() => ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: 25, minWidth: 25, maxHeight: 35, maxWidth: 35),
        child: SvgPicture.network(
          Api.imageCDNPath(group.svgImage),
        ),
      );

  Widget _groupTitleBuilder() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          group.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(3),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(body: CatalogListPage(group.id, group.name));
          }));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              group.svgImage != null ? _svgImageGroupBuilder() : Container(),
              _groupTitleBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkuItem extends StatelessWidget {
  final String parentName;
  final Catalog sku;
  _SkuItem(this.sku, [this.parentName = '_']);

  final TextStyle _actualPriceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.blueGrey[700],
  );
  final TextStyle _oldPriceStyle = TextStyle(
    fontSize: 14,
    color: Colors.blueGrey[500],
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.lineThrough,
  );

  Widget _skuTitle() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        sku.name,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _skuImageBuilder() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 70,
            child: Image.network(
              Api.imageCDNPath(sku.image),
              fit: BoxFit.contain,
              height: 85,
            ),
          ),
          sku.price is Price && sku.price.isPromo
              ? Positioned(
                  left: 3,
                  top: 4,
                  child: DiscountLabel(
                    label: '${sku.price.discount}%',
                    fontSize: 11,
                    angle: -0.2,
                  ))
              : Container(),
        ],
      ),
    );
  }

  Widget _notExistPrice() {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Text(
        'Цена не указана',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _skuPrice() {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sku.price.oldPrice != null
              ? Text(
                  '₽' + formattedPrice(sku.price.oldPrice),
                  style: _oldPriceStyle,
                )
              : Container(),
          Text(
            '₽' + formattedPrice(sku.price.price),
            style: _actualPriceStyle,
          ),
        ],
      ),
    );
  }

  Widget _skuContent() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _skuTitle(),
            sku.price != null ? _skuPrice() : _notExistPrice(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CatalogItemPage(sku.id, parentName);
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              sku.image != null ? _skuImageBuilder() : Container(),
              _skuContent(),
            ],
          ),
        ),
      ),
    );
  }
}
