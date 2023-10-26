import 'package:brasil_fields/brasil_fields.dart';
import 'package:calculadora_imc/pages/login_page.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = 'Usuario Teste';
  String _image = 'aaaaaaaa';
  String _text = 'aaaaaaaa';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cardColor,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Olá, $_nome',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.values[8],
                            color: backGroundColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.center,
                        child: _image == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundColor: backGroundColor,
                                child: FaIcon(
                                  FontAwesomeIcons.person,
                                  color: cardColor,
                                  size: 50,
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: backGroundColor,
                                radius: 50,
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, bottom: 20),
                        child: const Text(
                          'Seu IMC:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _text ?? 'Caracter sem valor',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, bottom: 20),
                        child: const Text(
                          'Seu IMC:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _text ?? 'Caracter sem valor',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, bottom: 20),
                        child: const Text(
                          'Seu IMC:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _text ?? 'Caracter sem valor',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: fontColorCard,
                          ),
                        ),
                      ),
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
