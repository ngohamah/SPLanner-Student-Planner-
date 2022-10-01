import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'providers/shared_utility_provider.dart';
import 'providers/storage_provider.dart';
import 'providers/theme_provider.dart';
import 'ui/pages/home_page.dart';
import 'utils/storage.dart';
import 'utils/styles/task_app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final storage = LocalStorage();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        storageProvider.overrideWithValue(storage),
      ],
      child: const Splash(),
    ),
  );
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: const MyApp(),
      duration: 4000,
      imageSize: 150,
      imageSrc: 'assets/images/splash.png',
      text: "SPLanner",
      textType: TextType.NormalText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: example1,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final bool isDark = ref.watch(isDarkProvider).getTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? TaskAppTheme.dark() : TaskAppTheme.light(),
          home: const Home(),
        );
      },
    );
  }
}
