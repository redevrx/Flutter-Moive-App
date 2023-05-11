import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/di/di.dart';
import 'package:movie_app/screen/authentication/signin_screen.dart';
import 'package:movie_app/view_model/auth_viewmodel/auth_viewmodel.dart';
import 'package:movie_app/view_model/moive/moive_viewmodel.dart';
import 'package:movie_app/view_model/nav/nav_viewmodel.dart';
import 'package:movie_app/view_model/theme/theme_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => GetIt.instance.get<AuthViewModel>()),
        ChangeNotifierProvider(
            create: (context) => GetIt.instance.get<ThemeViewModel>()),
        ChangeNotifierProvider(
            create: (context) => GetIt.instance.get<MoiveViewModel>()),
        ChangeNotifierProvider(
            create: (context) => GetIt.instance.get<NavViewModel>())
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (_, value, child) {
          return MaterialApp(
            theme: context.read<ThemeViewModel>().themeData,
            home: const SignInScreen(),
          );
        },
        child: const SizedBox());
  }
}
