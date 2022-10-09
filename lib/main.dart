import 'package:breaking_bad_app/app.dart';
import 'package:breaking_bad_app/helpers/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/bloc_observer.dart';
import 'helpers/routing_helper.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(App(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
