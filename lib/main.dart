import 'package:flutter/material.dart';
import 'package:image_background_remover/Provider/image_provider.dart';
import 'package:image_background_remover/View/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageProviderClass(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xffdf2935)),
          scaffoldBackgroundColor: const Color(0xffd9d9d9),
          appBarTheme:
              const AppBarTheme(centerTitle: true, color: Color(0xff507dbc)),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple, accentColor: Colors.red),
        ),
        home: const HomeView(),
      ),
    );
  }
}
