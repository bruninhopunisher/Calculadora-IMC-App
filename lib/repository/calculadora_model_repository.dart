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
    List<Map<String, dynamic>> _list =
        await database.rawQuery('SELECT * FROM CALCULADORA');

    CalculadoraIMCModel _calculadoraIMCModel = CalculadoraIMCModel(
      imc: _list[0]['imc'],
      peso: _list[0]['peso'],
      altura: _list[0]['altura'],
      email: _list[0]['email'],
      nome: _list[0]['nome'],
      sexo: _list[0]['sexo'],
      foto: _list[0]['foto'],
    );

    peso = _calculadoraIMCModel.peso;
    altura = _calculadoraIMCModel.altura;
    _imc = _calculadoraIMCModel.imc;
  }

  Future<double> _imcCalculator() async {
    List list = await _getDadosCalculadora();
    peso = list[1];
    altura = list[2];
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

    List<String> spliteClassificacao = _classificacao.split('\n');
    _classificacao = spliteClassificacao[0];

    await database.insert(
      'CALCULADORA',
      {
        'nome': '',
        'imc': _imc,
        'classificacao': _classificacao,
        'risco_comorbidade': _riscoComorbidade,
        'peso': peso,
        'altura': altura,
      },
    );
  }
}
