import 'package:flutter/material.dart';

import 'home_page.dart';

class LauncherPage extends StatefulWidget {

  static const String routeName='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1500)).then((value){
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26A6DE),
      body: Center(
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
