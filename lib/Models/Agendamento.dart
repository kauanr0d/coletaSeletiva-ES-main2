import 'package:intl/intl.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';

class Agendamento {
  TipoAgendamento? _tipoAgendamento;
  String? _descricaoAgendamento;
  int? _idAgendamento;
  DateTime? _dataAgendamento;

  Agendamento(this._tipoAgendamento, this._descricaoAgendamento,
      this._idAgendamento, this._dataAgendamento);

  //getters
  TipoAgendamento? get tipoAgendamento => _tipoAgendamento;
  String? get descricaoAgendamento => _descricaoAgendamento;
  int? get idAgendamento => _idAgendamento;
  DateTime? get dataAgendamento => _dataAgendamento;

  Map<String, dynamic> toMap() {
    return {
      'idAgendamento': _idAgendamento,
      'tipoAgendamentp':
          _tipoAgendamento?.toString(), // Converte o enum para uma string
      'descricaoAgendamento': _descricaoAgendamento,
      'dataAgendamento': _dataAgendamento
          ?.toIso8601String(), // Converte a data para uma string no formato ISO 8601
    };
  }

  Agendamento.fromMap(Map<String, dynamic> map)
      : _idAgendamento = map['id_agendamento'],
        _tipoAgendamento =
            _getTipoAgendamentoFromString(map['tipo_agendamento']),
        _descricaoAgendamento = map['descricao'],
        _dataAgendamento = DateTime.parse(map['data_agendamento']);

  static TipoAgendamento _getTipoAgendamentoFromString(String? valor) {
    if (valor == null) {
      return TipoAgendamento.outros;
    }

    for (TipoAgendamento tipo in TipoAgendamento.values) {
      if (tipo.toString().split('.').last == valor) {
        return tipo;
      }
    }

    return TipoAgendamento.outros;
  }

  String dataAgendamentoFormatada() {
    if (_dataAgendamento != null) {
      return DateFormat('dd/MM/yyyy').format(_dataAgendamento!);
    } else {
      return '';
    }
  }
}
