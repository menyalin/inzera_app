import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../api.dart';

class CatalogAPI {
  static String _path = 'catalog/';

  static Future<List<Catalog>> getCatalogGroup(
      Map<String, String> params) async {
    try {
      http.Response res = await Api.getMethod(_path, params);
      if (res.statusCode == 200) {
        List<Map<String, dynamic>> json =
            convert.jsonDecode(res.body).cast<Map<String, dynamic>>();
        return json.map<Catalog>((item) => Catalog.fromJson(item)).toList();
      } else {
        throw Exception('404');
      }
    } catch (e) {
      throw Exception('Ошибка запроса_2');
    }
  }

  static Future<Catalog> getCatalogById({String id}) async {
    try {
      http.Response res = await Api.getMethod(_path + id);
      if (res.statusCode == 200) {
        var jsonRes = convert.jsonDecode(res.body);
        return Catalog.fromJson(jsonRes);
      } else {
        throw Exception('Ошибка запроса');
      }
    } catch (e) {
      throw Exception('Ошибка запроса');
    }
  }
}

class Catalog {
  String name, id, type, image, abv, skuType, segment, svgImage;
  Detail company, brand, sommelier, recomendation;
  Price price;
  List<Series> series = [];

  Catalog(this.name, this.id, this.type, this.image);
  Catalog.fromJson(Map<String, dynamic> catalogJson) {
    this.name = catalogJson['name'];
    this.id = catalogJson['_id'];
    this.type = catalogJson['type'];

    if (catalogJson['type'] == 'group') {
      this.svgImage = catalogJson['mainImageUrl'] ?? null;
    } else if (catalogJson['type'] == 'item') {
      if (catalogJson['images'] != null && catalogJson['images'].length > 0) {
        this.image = catalogJson['images'][0];
      }
      if (catalogJson['series'] != null &&
          !(catalogJson['series'] is String) &&
          catalogJson['series']['sku'].length > 0) {
        for (int i = 0; i < catalogJson['series']['sku'].length; i++) {
          this.series.add(Series.fromJson(catalogJson['series']['sku'][i]));
        }
      }
      if (catalogJson['prices'] != null &&
          catalogJson['prices'] is List &&
          catalogJson['prices'].length > 0 &&
          catalogJson['prices'][0] is Map) {
        this.price = Price.fromJson(catalogJson['prices'][0]);
      }
      this.abv = catalogJson['abv']?.toString();
      this.skuType = catalogJson['skuType'];
      this.segment = catalogJson['segment'];
      this.company = catalogJson['company'] is Map
          ? Detail.fromJson(catalogJson['company'], 'Производитель')
          : null;
      this.sommelier = catalogJson['sommelier'] is Map
          ? Detail.fromJson(catalogJson['sommelier'], 'Электронный сомелье')
          : null;
      this.brand = catalogJson['brand'] is Map
          ? Detail.fromJson(catalogJson['brand'], 'О бренде')
          : null;
      this.recomendation = catalogJson['recomendation'] is Map
          ? Detail.fromJson(
              catalogJson['recomendation'], 'Рекомендуемое употребление')
          : null;
    } else {
      throw Exception('Ошибка конструктора Catalog.fromJson');
    }
  }
}

class Series {
  String volume, nameForSeries, skuId;
  Series.fromJson(Map<String, dynamic> json) {
    this.volume = json['volume'].toString();
    this.nameForSeries = json['nameForSeries'];
    this.skuId = json['_id'];
  }
  @override
  String toString() {
    return 'volume: ${this.volume}, nameForSeries: ${this.nameForSeries}';
  }
}

class Detail {
  String id, type, name, description, title;
  Detail.fromJson(Map<String, dynamic> json, String title) {
    this.id = json['_id'];
    this.type = json['type'];
    this.name = json['name'];
    this.description = json['description'];
    this.title = title;
  }
}

class Price {
  String id, promoDescription;
  bool isPromo;
  int discount;
  double price, oldPrice;
  Price.fromJson(Map<String, dynamic> json) {
    try {
      this.id = json['_id'];
      this.isPromo = json['isPromo'];
      this.promoDescription = json['promoDescription'] ?? null;
      this.price = json['price'].toDouble();
      this.oldPrice =
          json['oldPrice'] != null ? json['oldPrice'].toDouble() : null;
      this.discount = json['discount'].toInt();
    } catch (e) {
      throw Exception(e);
    }
  }
}
