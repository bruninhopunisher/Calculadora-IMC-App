import 'package:calculadora_imc/model/pessoa_model.dart';

class CalculadoraIMCModel extends PessoaModel {
  final double imc;
  final String classificacao;
  final String riscoComorbidade;

  CalculadoraIMCModel({
    required this.imc,
    required this.classificacao,
    required this.riscoComorbidade,
    required double peso,
    required double altura,
    required String email,
    required String nome,
    required String sexo,
    required String foto,
  }) : super(
          email: email,
          nome: nome,
          idade: 0,
          altura: altura,
          peso: peso,
          sexo: sexo,
          foto: foto,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'peso': peso,
      'sexo': sexo,
      'idade': idade,
      'altura': altura,
      'foto': foto,
      'imc': imc,
      'classificacao': classificacao,
      'risco_comorbidade': riscoComorbidade,
    };
  }
}
