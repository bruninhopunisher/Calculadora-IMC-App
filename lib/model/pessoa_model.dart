class PessoaModel {
  final String nome;
  final int idade;
  final double altura;
  final double peso;
  final String sexo;

  PessoaModel({
    required this.nome,
    required this.idade,
    required this.altura,
    required this.peso,
    required this.sexo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
    };
  }
}
