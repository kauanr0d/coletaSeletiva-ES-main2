import 'package:sqflite/sqflite.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/ConexaoBancoDeDados/Conexao.dart';
import 'package:projeto_coleta_seletiva/Interfaces/UsuarioDAO.dart';

class UsuarioDAOImpl implements UsuarioDAO {
  static Database? _db;
  UsuarioDAOImpl();

  @override
  Future<List<Usuario>> buscarUsuario(Usuario usuario) async {
    _db = await Conexao.getConexao();
    var sql = "SELECT * FROM usuario WHERE email = ? and senha = ?";
    await _db!.rawQuery(sql);
    throw UnimplementedError();
  }

  Future<Usuario?> carregarUsuario(Usuario usuario) async {
    _db = await Conexao.getConexao();
    var sql = "SELECT * FROM usuario WHERE idUsuario =  ?";
    List<Map<String, dynamic>> resultado =
        await _db!.rawQuery(sql, [usuario.idUsuario]);
    if (resultado.isEmpty) {
      return null;
    } else {
      return Usuario.fromMap(resultado.first);
    }
  }

  Future<Usuario?> login(String email, String senha) async {
    _db = await Conexao.getConexao();

    var sql = "SELECT * FROM usuario WHERE email = ? and senha = ? LIMIT 1";

    List<Map<String, dynamic>> resultado =
        await _db!.rawQuery(sql, [email, senha]);

    if (resultado.isEmpty != true) {
      return Usuario.fromMap(resultado.first);
    } else {
      return null;
    }
  }

  @override
  remover(Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "DELETE FROM usuario WHERE idUsuario = ?";
    await _db!.rawDelete(sql, [usuario.idUsuario]);
  }

  removerPorCpf(Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "DELETE FROM usuario WHERE cpf = ?";
    await _db!.rawDelete(sql, [usuario.cpf]);
    _db!.close();
  }

  @override
  salvarUsuario(Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql =
        "INSERT INTO usuario(nome,senha,cpf,telefone,email,CEP,bairro,rua,numero) VALUES(?,?,?,?,?,?,?,?,?);";
    await _db!.rawInsert(sql, [
      usuario.nome,
      usuario.senha,
      usuario.cpf,
      usuario.telefone,
      usuario.email,
      usuario.cep,
      usuario.bairro,
      usuario.rua,
      usuario.numero
    ]);
  }

  removerDadosDoUsuario(Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "delete from denuncia where idUsuario = ?";
    await _db!.rawDelete(sql, [usuario.idUsuario]);
    sql = "delete from agendamento where idUsuario = ?";
    await _db!.rawDelete(sql, [usuario.idUsuario]);
  }

  atualizarCadastro(Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql =
        "UPDATE usuario SET telefone = ?, email = ?, rua = ?, CEP = ?, bairro = ?, numero = ? WHERE idUsuario = ?";
    await _db!.rawUpdate(sql, [
      usuario.telefone,
      usuario.email,
      usuario.rua,
      usuario.cep,
      usuario.bairro,
      usuario.numero,
      usuario.idUsuario
    ]);
  }

  //Reset de senha, primeiro verifica se existe
  @override
  Future<bool> verificarUsuarioExistente(String email) async {
    var sql = "SELECT COUNT(*) FROM usuario WHERE email = ?";
    _db = await Conexao.getConexao();
    int count = Sqflite.firstIntValue(await _db!.rawQuery(sql, [email]))!;
    return count > 0;
  }

  @override
  Future<void> resetSenha(String email, String novaSenha) async {
    var sql = "UPDATE usuario SET senha = ? WHERE email = ?";
    _db = await Conexao.getConexao();
    await _db!.rawUpdate(sql, [novaSenha, email]);
  }
}
