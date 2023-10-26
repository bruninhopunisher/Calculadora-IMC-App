import 'package:calculadora_imc/pages/login_page.dart';
import 'package:calculadora_imc/pages/sign_up.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigatorLoginPage extends StatefulWidget {
  const NavigatorLoginPage({super.key});

  @override
  State<NavigatorLoginPage> createState() => _NavigatorLoginPageState();
}

class _NavigatorLoginPageState extends State<NavigatorLoginPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Column(
          children: [
            Expanded(
              child: Image(
                image: const AssetImage('assets/logo_imc.png'),
                width: MediaQuery.of(context).size.width * 0.45,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
                child: PageView(
                  controller: _pageController,
                  children: const [
                    LoginPage(),
                    SignUPPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
