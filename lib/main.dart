import 'package:danesh_calculator/provider/calculator_provider.dart';
import 'package:danesh_calculator/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'launcher_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>CalculatorProvider()),
    ],
      child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        HomePage.routeName:(context)=>HomePage(),
        LauncherPage.routeName:(context)=>LauncherPage(),
      },
    );
  }
}

