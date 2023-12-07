import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/ConexaoBancoDeDados/Conexao.dart';
import 'package:projeto_coleta_seletiva/Interfaces/DenunciaDAO.dart';

class DenunciaDAOImpl implements DenunciaDAO {
  static Database? _db;

  @override
  Future<List<Denuncia>> buscarDenuncia(Denuncia denuncia) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "select * from denuncia where id_denuncia = ?";
    _db!.rawQuery(sql, [denuncia.idDenuncia]);
    _db!.close();
    throw UnimplementedError();
  }

  @override
  remover(Denuncia denuncia) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "DELETE FROM denuncia WHERE id_denuncia = ?";
    await _db!.rawDelete(sql, [denuncia.idDenuncia]);
    _db!.close();
    throw UnimplementedError();
  }

  @override
  salvarDenuncia(Denuncia denuncia, Usuario usuarioDenunciante) async {
    var sql;
    _db = await Conexao.getConexao();
    if (denuncia.cep != null) {
      sql =
          "INSERT INTO denuncia (id_usuario, tipo_denuncia, descricao, CEP, bairro, rua, numero, data_denuncia)VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    } else {
      sql =
          "INSERT INTO denuncia (id_usuario, tipo_denuncia, descricao, CEP, bairro, rua, numero, data_denuncia)VALUES (?, ?, ?, ?, ?, ?, ?)";
    }
    await _db!.rawInsert(sql, [
      usuarioDenunciante.idUsuario,
      denuncia.tipoDenuncia?.name.toString(),
      denuncia.descricaoDenuncia,
      denuncia.cep,
      denuncia.bairro,
      denuncia.rua,
      denuncia.numero,
      denuncia.dataDenuncia?.toLocal().toString()
    ]);
    throw UnimplementedError();
  }

  @override
  Future<List<Denuncia>> listarDenuncias(Usuario usuario) async {
    try {
      _db = await Conexao.getConexao();
      var sql = "SELECT * FROM denuncia WHERE id_usuario = ? ";
      List<Map<String, dynamic>> result =
          await _db!.rawQuery(sql, [usuario.idUsuario]);

      List<Denuncia> denuncias =
          result.map((map) => Denuncia.fromMap(map)).toList();
      return denuncias;
    } catch (e) {
      print("Erro ao listar denúncias: $e");
      return []; // Retorna uma lista vazia em caso de erro
    }
  }
}
