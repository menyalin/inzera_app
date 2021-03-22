import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogImageScreen extends StatelessWidget {
  final String imageUrl, name;
  CatalogImageScreen({this.imageUrl, this.name});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(name ?? ''),
      ),
      child: SafeArea(
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
