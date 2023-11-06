import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:calculadora_imc/database/db.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  sqfliteTestInit();  
  test('Query method Database class', () async {
    DB db = DB();
    PessoaModel pessoaTest = PessoaModel(
      id: 1,
      nome: "Teste",
      idade: 20,
      peso: 80,
      altura: 1.80,
      sexo: "Masculino",
      foto: "foto",
    );

    // Na segunda execução, o banco já existe e o modelo tambem por isso acaba retornando um erro
    // deixei o try catch para não quebrar o teste, mas o ideal é que o banco seja apagado antes de cada teste
    try {
      await db.openDataBase(pessoaTest);
    } catch (e) {
      print(e);
    }

    // Roda o query method e armazena o resultado
    var result = await db.query("*", "PESSOA", "id = 1");
    
    // Verifica se o resultado é diferente de null e se o nome é igual ao esperado
    expect(result, isNotNull);
    expect(result.first['nome'], 'Teste');
  });
}