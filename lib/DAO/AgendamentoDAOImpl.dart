import 'package:projeto_coleta_seletiva/Interfaces/AgendamentoDAO.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_coleta_seletiva/ConexaoBancoDeDados/Conexao.dart';
import 'package:projeto_coleta_seletiva/Interfaces/AgendamentoDAO.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class AgendamentoDAOImpl implements AgendamentoDAO {
  static Database? _db;

  @override
  Future<List<Agendamento>> buscarAgendamento(Agendamento agendamento) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "select * from agendamento where id_agendamento = ?";
    _db!.rawQuery(sql, [agendamento.idAgendamento]);
    _db!.close();
    throw UnimplementedError();
  }

  @override
  remover(Agendamento agendamento) async {
    var sql;
    _db = await Conexao.getConexao();
    sql = "DELETE FROM agendamento WHERE id_agendamento = ?";
    await _db!.rawDelete(sql, [agendamento.idAgendamento]);
    _db!.close();
  }

  @override
  salvarAgendamento(Agendamento agendamento, Usuario usuario) async {
    var sql;
    _db = await Conexao.getConexao();
    sql =
        "INSERT INTO agendamento (id_usuario,tipo_agendamento,data_agendamento,descricao) values(?,?,?,?)";
    await _db!.rawInsert(sql, [
      usuario.idUsuario,
      agendamento.tipoAgendamento?.name.toString(),
      agendamento.dataAgendamento?.toLocal().toString(),
      agendamento.descricaoAgendamento
    ]);
  }

  Future<List<Agendamento>> listarAgendamentos(Usuario usuario) async {
    try {
      _db = await Conexao.getConexao();
      var sql = "SELECT * FROM agendamento WHERE id_usuario = ? ";
      List<Map<String, dynamic>> result =
          await _db!.rawQuery(sql, [usuario.idUsuario]);

      List<Agendamento> agendamentos =
          result.map((map) => Agendamento.fromMap(map)).toList();
      return agendamentos;
    } catch (e) {
      print("Erro ao listar agendamentos: $e");
      return [];
    }
  }
}
