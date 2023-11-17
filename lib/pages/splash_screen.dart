import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_login_page.dart';
import 'package:calculadora_imc/utils/navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  openHome() async {
    Database database = await DB.instance.database;
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM PESSOA');

    if (list.isNotEmpty) {
      Future.delayed(
        const Duration(milliseconds: 2500),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorPage(),
            ),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 1500),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorLoginPage(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    openHome();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Center(
          child: Image(
            image: const AssetImage('assets/logo_imc.png'),
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
      ),
    );
  }
}
