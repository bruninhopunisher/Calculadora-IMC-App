class Pessoa {
  String _nome = 'Usuario Teste';
  int _idade = 18;
  double _altura = 1.59;
  double _peso = 105;
  String _sexo = 'Masculino';

  set setNome(String nome) => _nome = nome;
  get getNome => _nome;

  set setIdade(int idade) => _idade = idade;
  get getIdade => _idade;

  set setAltura(double altura) => _altura = altura;
  get getAltura => _altura;

  set setPeso(double peso) => _peso = peso;
  get getPeso => _peso;

  set setSexo(String sexo) => _sexo = sexo;
  get getSexo => _sexo;
}
