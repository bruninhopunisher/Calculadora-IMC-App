import 'package:calculadora_imc/model/pessoa_model.dart';

class CalculadraIMCModel extends PessoaModel {
  final double imc;

  CalculadraIMCModel({
    required this.imc,
    required peso,
    required altura,
    required int id,
    required String nome,
    required int idade,
    required String sexo,
    required String foto,
  }) : super(
          id: id,
          nome: nome,
          idade: idade,
          altura: altura,
          peso: peso,
          sexo: sexo,
          foto: foto,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'altura': altura,
      'foto': foto,
    };
  }
}
