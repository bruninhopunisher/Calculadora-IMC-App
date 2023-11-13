class PessoaModel {
  final String email;
  final String nome;
  final int idade;
  final double altura;
  final double peso;
  final String sexo;
  final String foto;

  PessoaModel({
    required this.email,
    required this.nome,
    required this.idade,
    required this.altura,
    required this.peso,
    required this.sexo,
    required this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'idade': idade,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
      'foto': foto,
    };
  }
}
