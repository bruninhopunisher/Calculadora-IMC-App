import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/navigator_page.dart';
import 'package:calculadora_imc/utils/terms_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController controller = ScrollController();
  bool _controllerEnter = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    Database database = await DB.instance.database;
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM PESSOA');

    if (list.isNotEmpty) {
      _controllerEnter = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.values[8],
                  color: backGroundColor,
                ),
              ),
              const Text(
                'Sejam bem-vindos a Calculadora IMC',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: fontColorCard),
              ),
              ElevatedButton(
                onPressed: () async {
                  _controllerEnter == false
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: cardColor,
                            title: const Text(
                              'Atenção',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: backGroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'Você não possui cadastro, por favor, cadastre-se arrastando para o lado.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: backGroundColor,
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: backGroundColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: const NavigatorPage(),
                            type: PageTransitionType.rightToLeft,
                            isIos: true,
                            duration: const Duration(milliseconds: 750),
                          ),
                          (route) => false);
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(20),
                  backgroundColor: MaterialStateProperty.all(
                    backGroundColor,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'Primeiro acesso?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: backGroundColor,
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: fontColorCard2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 15,
                  ),
                  child: const Text(
                    'Arraste para o lado',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_outlined),
                  TextButton(
                    child: const Text(
                      'Termos de uso',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: backGroundColor,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: false,
                        context: context,
                        backgroundColor: cardColor,
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: terms.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      terms[index],
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: backGroundColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
