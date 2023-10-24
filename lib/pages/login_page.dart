import 'package:calculadora_imc/pages/sign_up.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:calculadora_imc/utils/terms_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController controller = ScrollController();
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
                child: Card(
                  color: cardColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
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
                        onPressed: () {},
                        style: ButtonStyle(
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUPPage()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            fontColorCard,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 74,
                              vertical: 15,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Cadastre-se',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                                        top: 20,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
