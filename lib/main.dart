import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_supplications_application/modules/prayers_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'shared/app_cubit/cubit_app.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => AppCubit()..crearDb(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),

      // Add Arabic to the supported locales list
      supportedLocales: [
        Locale('ar'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: PrayersPage(),
    );
  }
}
