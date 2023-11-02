import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/calculadora_model.dart';
import 'package:sqflite/sqflite.dart';

class CalculadoraIMC {
  late double peso;
  late double altura;
  late double _imc;
  late String _classificacao;
  late String _riscoComorbidade;

  _getDadosCalculadora() async {
    Database database = await DB.instance.database;
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM CALCULADORA');

    CalculadraIMCModel calculadoraIMCModel = CalculadraIMCModel(
      imc: list[0]['seu_imc'],
      peso: list[0]['peso'],
      altura: list[0]['altura'],
      id: 0,
      nome: '',
      idade: 0,
      sexo: '',
      foto: '',
    );
  }

  Future<double> _imcCalculator() async {
    List dados = await _getDadosCalculadora();
    peso = dados[1];
    altura = dados[2];
    _imc = peso / (altura * altura);
    return _imc;
  }

  Future<String> classificacaoIMC() async {
    double imc = await _imcCalculator();
    if (imc < 18.5) {
      _classificacao = 'Abaixo do peso \n Baixo';
    } else if (imc >= 18.5 && imc <= 24.9) {
    } else if (imc >= 25 && imc <= 29.9) {
      _classificacao = 'Sobrepeso \n Pouco elevado';
    } else if (imc >= 30 && imc <= 34.9) {
      _classificacao = 'Obesidade grau 1 \n Elevado';
    } else if (imc >= 35 && imc <= 39.9) {
      _classificacao = 'Obesidade grau 2 \n Muito elevado';
    } else if (imc >= 40) {
      _classificacao = 'Obesidade grau 3 \n Muitíssimo elevado';
    }
    return _classificacao;
  }

  Future<void> inserirDatabase() async {
    Database database = await DB.instance.database;
  }
}
