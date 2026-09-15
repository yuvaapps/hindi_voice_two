import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiNumberMatchingApp(),
    ),
  );
}

class HindiNumberMatchingApp extends StatelessWidget {
  const HindiNumberMatchingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Matching',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}
