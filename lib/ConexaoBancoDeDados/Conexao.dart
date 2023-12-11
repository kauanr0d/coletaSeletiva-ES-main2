import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class Conexao {
  static Database? _db;
  static String nomeDoBanco = 'bancoColetaSeletiva.db';

  static Future<Database> getConexao() async {
    //databaseFactory = databaseFactoryFfi;

    if (_db == null) {
      Directory diretorio = await getApplicationDocumentsDirectory();
      String caminho = '${diretorio.path}/bancoColetaSeletiva.db';
      //ignore: avoid_print
      print(caminho);
      _db = await openDatabase(caminho,
          version: 1, singleInstance: false, onCreate: _onCreate);
    }
    if (_db != null) {
      return _db!;
    } else {
      throw Exception("Falha ao obter conexão com o banco de addos!");
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Tabela Usuário
    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS usuario (
        idUsuario INTEGER NOT NULL PRIMARY KEY UNIQUE,
        nome VARCHAR(50) NOT NULL,
        senha VARCHAR(30) NOT NULL,
        cpf VARCHAR(11) NOT NULL UNIQUE,
        telefone VARCHAR(11) NOT NULL UNIQUE,
        email VARCHAR(40) NOT NULL UNIQUE,
        CEP VARCHAR(9) NOT NULL,
        bairro TEXT NOT NULL,
        rua TEXT NOT NULL,
        numero TEXT NOT NULL
      );
    ''');

    // Index no campo cpf do Usuário
    await db.execute(
        '''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_cpf_usuario ON usuario(cpf);
    ''');

    // Tabela Agendamento
    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS agendamento (
        id_agendamento INTEGER NOT NULL PRIMARY KEY UNIQUE,
        descricao TEXT NOT NULL,
        id_usuario INTEGER NOT NULL,
        data_agendamento DATE NOT NULL,
        tipo_agendamento TEXT NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario)
      );
    ''');

    // Tabela Denuncia
    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS denuncia (
        id_denuncia INTEGER NOT NULL PRIMARY KEY UNIQUE,
        id_usuario INTEGER NOT NULL,
        tipo_denuncia TEXT NOT NULL,
        descricao TEXT,
        CEP VARCHAR(16),
        bairro TEXT NOT NULL,
        rua TEXT NOT NULL,
        numero TEXT,
        data_denuncia DATE NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario)
      );
    ''');
  }
}
