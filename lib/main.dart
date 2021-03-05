import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'appState.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: InzeraApp(),
  ));
}
