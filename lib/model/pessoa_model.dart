class PessoaModel {
  final int id;
  final String nome;
  final int idade;
  final double altura;
  final double peso;
  final String sexo;

  PessoaModel({
    required this.id,
    required this.nome,
    required this.idade,
    required this.altura,
    required this.peso,
    required this.sexo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
    };
  }
}
