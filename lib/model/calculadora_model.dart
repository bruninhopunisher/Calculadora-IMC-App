import 'package:calculadora_imc/model/pessoa_model.dart';

class CalculadoraIMCModel extends PessoaModel {
  final double imc;

  CalculadoraIMCModel({
    required this.imc,
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
      'imc': imc,
      'peso': peso,
      'sexo': sexo,
      'idade': idade,
      'altura': altura,
      'foto': foto,
    };
  }
}
