import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inzera_app2/catalogPage/catalogItem/catalogItemPage.dart';
import 'package:inzera_app2/models/catalogModel.dart';
import 'package:inzera_app2/utils/helpers.dart';

class CatalogMainInfoItem extends StatelessWidget {
  final String parentName;
  final Catalog catalog;

  CatalogMainInfoItem(this.catalog, [this.parentName = '']);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PriceInfo(price: catalog.price),
          Divider(),
          catalog.series.length > 0
              ? _CatalogSeries(catalog, parentName)
              : Container(),
          Divider(),
          catalog.company != null
              ? _MainInfoField('Производитель: ${catalog.company.name}')
              : Container(),
          catalog.skuType != null && catalog.skuType.isNotEmpty
              ? _MainInfoField('Тип: ${catalog.skuType}')
              : Container(),
          catalog.abv != null && catalog.abv.isNotEmpty
              ? _MainInfoField('Крепость: ${catalog.abv}%')
              : Container(),
          catalog.segment != null && catalog.segment.isNotEmpty
              ? _MainInfoField('Сегмент: ${catalog.segment}')
              : Container(),
        ],
      ),
    );
  }
}

class _MainInfoField extends StatelessWidget {
  final String _str;

  final _infoTextStyles = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  _MainInfoField(this._str);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 3),
      child: Text(_str, style: _infoTextStyles),
    );
  }
}

class _CatalogSeries extends StatelessWidget {
  final Catalog _catalog;
  final String parentName;
  _CatalogSeries(this._catalog, [this.parentName = '_']);

  _seriesTextStyles() => TextStyle(
        fontSize: 14,
      );
  _seriesTitleTextStyle() => TextStyle(color: Colors.grey[600]);

  Widget _seriesTitle() => Container(
        padding: EdgeInsets.only(left: 5, top: 5),
        child: Text(
          'Продукция из этой серии:',
          style: _seriesTitleTextStyle(),
        ),
      );
  Widget _seriesButton(
      {Series sku, String owner, BuildContext context, String parentName}) {
    _buttonClick() {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) {
          return CatalogItemPage(sku.skuId, parentName);
        }),
      );
    }

    return OutlinedButton(
      style: ButtonStyle(),
      onPressed: owner != sku.skuId ? _buttonClick : null,
      child: Text(
          '${sku.nameForSeries != null && sku.nameForSeries.isNotEmpty ? sku.nameForSeries : sku.volume}',
          style: _seriesTextStyles()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _seriesTitle(),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 30,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int i) => SizedBox(
              width: 20,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: _catalog.series.length,
            itemBuilder: (BuildContext context, int i) {
              return _seriesButton(
                sku: _catalog.series[i],
                owner: _catalog.id,
                context: context,
                parentName: parentName,
              );
            },
          ),
        )
      ],
    );
  }
}

class _PriceInfo extends StatelessWidget {
  final Price price;
  _PriceInfo({this.price});
  _actualPriceStyle() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[600],
      );
  _oldPriceStyle() => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.blueGrey[600],
        decoration: TextDecoration.lineThrough,
      );

  Widget _priceField(Price price) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '₽${formattedPrice(price.price)}',
              style: _actualPriceStyle(),
            ),
          ),
          price.oldPrice != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('₽${formattedPrice(price.oldPrice)}',
                      style: _oldPriceStyle()),
                )
              : Container(),
          Container(
            child: OutlinedButton(
              onPressed: () {
                print('Received click');
              },
              child: Container(
                child: Text('Где купить?',
                    style: TextStyle(
                      fontSize: 14,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 7),
      child: price != null ? _priceField(price) : Text('Цена не указана'),
    );
  }
}
