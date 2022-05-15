import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/Bloc_Observer.dart';

import 'layout/Home_Layout.dart';

void main() {
  BlocOverrides.runZoned(
        () => runApp(MyApp()),

    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Layout(),
    );
  }
}
