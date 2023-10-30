import 'package:calculadora_imc/model/pessoa_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Construtor com acesso privado
  DB._();

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
      peso TEXT,
      altura TEXT,
      sexo TEXT
    )
  ''';

  String get _calculadora => '''
    CREATE TABLE CALCULADORA (
      imc TEXT,
      classificacao TEXT,
      risco_comorbidade TEXT
    )
  ''';

  // Inserir dados na tabela
  Future<int> openDataBase(PessoaModel pessoaModel) async {
    Database database = await _initDatabase();

    return await database.insert('PESSOA', pessoaModel.toMap());
  }
}
