import 'dart:io';

import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/calculadora_model.dart';
import 'package:calculadora_imc/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = '';
  XFile? _image;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    Database database = await DB.instance.database;

    List<Map<String, dynamic>> listCalculadora =
        await database.rawQuery('SELECT * FROM CALCULADORA');

    CalculadoraIMCModel calculadoraIMCModel = CalculadoraIMCModel(
      imc: listCalculadora[0]['imc'] ?? 0,
      peso: listCalculadora[0]['peso'] ?? 0,
      altura: listCalculadora[0]['altura'],
      nome: listCalculadora[0]['nome'],
      email: listCalculadora[0]['email'],
      sexo: listCalculadora[0]['sexo'],
      foto: listCalculadora[0]['foto'],
    );

    _nome = calculadoraIMCModel.nome;
    _image = XFile(calculadoraIMCModel.foto);

    if (kDebugMode) {
      print(
          '--------------Calculadora Home Page ----------------- ${calculadoraIMCModel.toMap()}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              backgroundImage: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/12631/12631691.png'),
                              child: FaIcon(
                                FontAwesomeIcons.person,
                                color: cardColor,
                                size: 50,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(
                                File(_image!.path),
                              ),
                              radius: 50,
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, bottom: 15),
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
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: fontColorCard,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, bottom: 15),
                      child: const Text(
                        'Classificação:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: fontColorCard,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: fontColorCard,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, bottom: 15),
                      child: const Text(
                        'Risco de Comorbidade:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: fontColorCard,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        '',
                        style: TextStyle(
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
    );
  }
}
