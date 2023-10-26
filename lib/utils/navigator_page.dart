import 'package:calculadora_imc/pages/home_page.dart';
import 'package:calculadora_imc/pages/profile.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  String _nome = 'Usuario';
  String _image = 'aaaaaaaa';
  String _text = 'aaaaaaaa';

  int _currentIndex = 0;
  final _pageController = PageController();

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
            AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: 2,
              effect: const SwapEffect(
                type: SwapType.yRotation,
                spacing: 10,
                dotColor: Colors.grey,
                activeDotColor: cardColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
                child: Card(
                  color: cardColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: const [
                      HomePage(),
                      Profile(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
