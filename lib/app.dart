import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:breaking_bad_app/shared/styles/colors.dart';

import 'helpers/routing_helper.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}