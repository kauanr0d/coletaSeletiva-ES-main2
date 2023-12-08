import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';
import 'package:intl/intl.dart';

class Denuncia {
  TipoDenuncia? _tipoDenuncia;
  String? _descricaoDenuncia;
  int? _idDenuncia;
  DateTime? _dataDenuncia;
  String? _bairro;
  String? _cep;
  String? _rua;
  String? _numero;

  Denuncia(
    this._tipoDenuncia,
    this._descricaoDenuncia,
    this._idDenuncia,
    this._dataDenuncia, {
    String? bairro,
    String? cep,
    String? rua,
    String? numero,
  })  : _bairro = bairro,
        _cep = cep,
        _rua = rua,
        _numero = numero;

  TipoDenuncia? get tipoDenuncia => _tipoDenuncia;
  String? get descricaoDenuncia => _descricaoDenuncia;
  int? get idDenuncia => _idDenuncia;
  DateTime? get dataDenuncia => _dataDenuncia;
  String? get bairro => _bairro;
  String? get cep => _cep;
  String? get rua => _rua;
  String? get numero => _numero;

  Map<String, dynamic> toMap() {
    return {
      'idDenuncia': _idDenuncia,
      'tipoDenuncia':
          _tipoDenuncia?.toString(), // Converte o enum para uma string
      'descricaoDenuncia': _descricaoDenuncia,
      'cep': _cep,
      'bairro': _bairro,
      'rua': _rua,
      'numero': _numero,
      'dataDenuncia': _dataDenuncia
          ?.toIso8601String(), // Converte a data para uma string no formato ISO 8601
    };
  }

  Denuncia.fromMap(Map<String, dynamic> map)
      : _idDenuncia = map['id_denuncia'],
        _tipoDenuncia = _getTipoDenunciaFromString(map['tipo_denuncia']),
        _descricaoDenuncia = map['descricao'],
        _cep = map['CEP'],
        _bairro = map['bairro'],
        _rua = map['rua'],
        _numero = map['numero'],
        _dataDenuncia = DateTime.parse(map['data_denuncia']);

  static TipoDenuncia _getTipoDenunciaFromString(String? valor) {
    if (valor == null) {
      return TipoDenuncia.outros;
    }

    for (TipoDenuncia tipo in TipoDenuncia.values) {
      if (tipo.toString().split('.').last == valor) {
        return tipo;
      }
    }

    return TipoDenuncia.outros;
  }

  String dataDenunciaFormatada() {
    if (_dataDenuncia != null) {
      return DateFormat('dd/MM/yyyy HH:mm').format(_dataDenuncia!);
    } else {
      return '';
    }
  }
}
