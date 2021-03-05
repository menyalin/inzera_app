import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inzera_app2/catalogPage/catalogItem/catalogImageScreen.dart';
import 'package:inzera_app2/common/discountLabel.dart';
import 'package:inzera_app2/models/catalogModel.dart';

class CatalogItemImage extends StatelessWidget {
  final String imageUrl, name;
  final Price price;

  CatalogItemImage(this.imageUrl, this.price, this.name);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Hero(
                tag: imageUrl,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (BuildContext context) {
                        return CatalogImageScreen(
                          imageUrl: imageUrl,
                          name: name,
                        );
                      }),
                    );
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          price != null && price.isPromo
              ? Positioned(
                  top: 40,
                  left: 5,
                  child: DiscountLabel(
                    label: 'Скидка ${price.discount}%',
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
