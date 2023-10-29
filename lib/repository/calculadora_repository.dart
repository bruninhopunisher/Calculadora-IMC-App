// import 'package:calculadora_imc/database/db.dart';
// import 'package:calculadora_imc/model/pessoa_model.dart';
// import 'package:sqflite/sqflite.dart';

// class CalculadoraIMC {
//   late Database db;
//   late double peso;
//   late double altura;
//   late double imc;

//   _getDadosCalculadora() async {
//     db = await DB.instance.database;
//     List pessoa = await db.query('PESSOA');
//     String _peso = pessoa.first['peso'];
//     String _altura = pessoa.first['altura'];
//     peso = double.parse(_peso);
//     altura = double.parse(_altura);

//     return [peso, altura];
//   }

//   Future<double> imcCalculator() async {
//     List dados = await _getDadosCalculadora();
//     peso = dados[0];
//     altura = dados[1];
//     imc = peso / (altura * altura);
//     return imc;
//   }

  // double imcCalculator(PessoaModel pessoa) {
  //   return (pessoa.getPeso() / (pessoa.getAltura() * pessoa.getAltura()));
  // }
// }
