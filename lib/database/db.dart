import 'package:calculadora_imc/model/calculadora_model.dart';
import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Construtor com acesso privado
  DB._();

  // Construtor para uso publico dos métodos
  DB();

  // Instância única de DB
  static final DB instance = DB._();

  // Instância do banco de dados
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  // Iniciar o banco de dados e criar o banco
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'calculadora_imc.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Criação das tabelas
  _onCreate(db, versao) async {
    await db.execute(_pessoa);
    await db.execute(_calculadora);
  }

  // Criação das estruturas das tabelas
  String get _pessoa => '''
    CREATE TABLE PESSOA (
      id INTEGER AUTO_INCREMENT PRIMARY KEY,
      nome TEXT,
      idade INTEGER,
      peso DOUBLE,
      altura DOUBLE,
      sexo TEXT,
      foto TEXT
    )
  ''';

  String get _calculadora => '''
    CREATE TABLE CALCULADORA (
      id INTEGER PRIMARY KEY,
      nome TEXT,
      idade INTEGER,
      peso DOUBLE,
      altura DOUBLE,
      sexo TEXT,
      seu_imc DOUBLE,
      classificacao TEXT,
      risco_comorbidade TEXT,
      foto TEXT,
      FOREIGN KEY (id, nome, peso, altura, sexo) REFERENCES PESSOA (id, nome, peso, altura, sexo)
  )
  ''';

  // Inserir dados na tabela Pessoa
  Future<int> openTablePessoa(PessoaModel pessoaModel) async {
    Database database = await _initDatabase();

    return await database.insert('PESSOA', pessoaModel.toMap());
  }

  // Recuperar dados na tabela Pessoa
  Future<PessoaModel> retriveDadosPessoa() async {
    Database database = await _initDatabase();
    final List<Map<String, dynamic>> pessoaModel =
        await database.rawQuery('PESSOA');
    return PessoaModel(
      id: pessoaModel[0]['id'],
      nome: pessoaModel[0]['nome'],
      idade: pessoaModel[0]['idade'],
      altura: pessoaModel[0]['altura'],
      peso: pessoaModel[0]['peso'],
      sexo: pessoaModel[0]['sexo'],
      foto: pessoaModel[0]['foto'],
    );
  }

// <<<<<<< gab3-dev
//   // Query from database
//   Future<List<Map<String, dynamic>>> query(String? fields, String? table, String? condition) async {
//     Database database = await _initDatabase();
//     List<Map<String, dynamic>> maps;
//     if(table == null) {
//       throw Exception('-------------------- Tabela não informada --------------------');
//     }
//     if(fields == null) {
//       maps = await database.rawQuery('SELECT * FROM $table');
//       return maps;
//     }
//     if(condition == null) {
//       maps = await database.rawQuery('SELECT $fields FROM $table');
//       return maps;
//     }
//     maps = await database.rawQuery('SELECT $fields FROM $table WHERE $condition');
//     return maps;
//   }

//   // Uptade de dados na tabela Pessoa
// =======
//   // Update de dados na tabela Pessoa
// >>>>>>> main
  Future<void> updatePessoa(PessoaModel pessoaModel) async {
    Database database = await _initDatabase();
    await database.update(
      'PESSOA',
      pessoaModel.toMap(),
      where: 'id = ?',
      whereArgs: [pessoaModel.id],
    );
  }

  // Deletar dados na tabela Pessoa
  Future<void> deletePessoa(int id) async {
    Database database = await _initDatabase();
    await database.delete(
      'PESSOA',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Inserir dados na tabela Calculadora
  Future<int> openTableCalculadora(
      CalculadoraIMCModel calculadraIMCModel) async {
    Database database = await _initDatabase();

    return await database.insert('CALCULADORA', calculadraIMCModel.toMap());
  }

  // Recuperar dados na tabela calculadora
  Future<CalculadoraIMCModel> retriveDadosCalculadora() async {
    Database database = await _initDatabase();
    final List<Map<String, dynamic>> calculadoraIMCModel =
        await database.rawQuery('SELECT * FROM CALCULADORA');
    return CalculadoraIMCModel(
      imc: calculadoraIMCModel[0]['seu_imc'],
      peso: calculadoraIMCModel[0]['peso'],
      altura: calculadoraIMCModel[0]['altura'],
      id: calculadoraIMCModel[0]['id'],
      nome: '',
      sexo: '',
      foto: '',
    );
  }
}
