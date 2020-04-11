import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutterroad/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Remove debug banner
  WidgetsApp.debugAllowBannerOverride = false;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
