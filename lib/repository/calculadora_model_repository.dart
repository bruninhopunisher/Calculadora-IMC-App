import 'dart:math';

import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/calculadora_model.dart';
import 'package:sqflite/sqflite.dart';

class CalculadoraIMCRepository {
  Future<void> calcularIMC() async {
    double imc = 0;
    String classificacao = '';
    String riscoComorbidade = '';
    Database database = await DB.instance.database;

    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM CALCULADORA');

    CalculadoraIMCModel calculadoraIMCModel = CalculadoraIMCModel(
      imc: list[0]['imc'] ?? 0,
      classificacao: list[0]['classificacao'] ?? '',
      riscoComorbidade: list[0]['risco_comorbidade'] ?? '',
      peso: list[0]['peso'],
      altura: list[0]['altura'],
      email: list[0]['email'],
      nome: list[0]['nome'],
      sexo: list[0]['sexo'],
      foto: list[0]['foto'],
    );

    imc =
        (calculadoraIMCModel.peso * 10000) / pow(calculadoraIMCModel.altura, 2);

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso \n Baixo';
    } else if (imc >= 18.5 && imc <= 24.9) {
    } else if (imc >= 25 && imc <= 29.9) {
      classificacao = 'Sobrepeso \n Pouco elevado';
    } else if (imc >= 30 && imc <= 34.9) {
      classificacao = 'Obesidade grau 1 \n Elevado';
    } else if (imc >= 35 && imc <= 39.9) {
      classificacao = 'Obesidade grau 2 \n Muito elevado';
    } else if (imc >= 40) {
      classificacao = 'Obesidade grau 3 \n Muitíssimo elevado';
    }

    List<String> spliteClassificacao = classificacao.split('\n');
    if (spliteClassificacao.length > 1) {
      riscoComorbidade = spliteClassificacao[1];
    }

    CalculadoraIMCModel calculadoraIMCModelUpdate = CalculadoraIMCModel(
      imc: imc,
      classificacao: classificacao,
      riscoComorbidade: riscoComorbidade,
      peso: calculadoraIMCModel.peso,
      altura: calculadoraIMCModel.altura,
      email: calculadoraIMCModel.email,
      nome: calculadoraIMCModel.nome,
      sexo: calculadoraIMCModel.sexo,
      foto: calculadoraIMCModel.foto,
    );

    await DB.instance.updateCalculadora(calculadoraIMCModelUpdate);

    // if (kDebugMode) {
    //   print('----------------- IMC ----------------- ${imc.toString()}');
    //   print(
    //       '----------------- Classificação ----------------- ${classificacao.toString()}');
    //   print(
    //       '----------------- Risco Comorbidade ----------------- ${riscoComorbidade.toString()}');
    // }
  }
}
