import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/environment.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: AppConfig.instance.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}