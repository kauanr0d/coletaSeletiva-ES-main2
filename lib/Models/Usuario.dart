import 'dart:convert';
import 'dart:math';

class Usuario {
  String? _nome;
  String? _senha;
  String? _cpf;
  String? _telefone;
  String? _email;
  int? _idUsuario;
  String? _bairro;
  String? _cep;
  String? _rua;
  String? _numero;
  //List<Denuncia>? _denuncias = [];
  //List<Agendamento>? _agendamentos = [];

  String? get nome => _nome;
  String? get senha => _senha;
  String? get cpf => _cpf;
  String? get telefone => _telefone;
  String? get email => _email;
  int? get idUsuario => _idUsuario;
  String? get cep => _cep;
  String? get bairro => _bairro;
  String? get rua => _rua;
  String? get numero => _numero;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idUsuario"] = _idUsuario;
    map["email"] = _email;
    map["senha"] = _senha;
    map["nome"] = _nome;
    map["cpf"] = _cpf;
    map["telefone"] = _telefone;
    map["bairro"] = _bairro;
    map["cep"] = _cep;
    map["rua"] = _rua;
    map["numero"] = _numero;
    return map;
  }

  Usuario(
      {String? nome,
      String? senha,
      String? cpf,
      String? telefone,
      String? email,
      int? idUsuario,
      String? bairro,
      String? cep,
      String? rua,
      String? numero})
      : _nome = nome,
        _senha = senha,
        _cpf = cpf,
        _telefone = telefone,
        _email = email,
        _idUsuario = idUsuario,
        _bairro = bairro,
        _cep = cep,
        _rua = rua,
        _numero = numero;

  Usuario.fromMap(dynamic obj) {
    _idUsuario = obj['idUsuario'];
    _email = obj['email'];
    _senha = obj['senha'];
    _nome = obj['nome'];
    _cpf = obj['cpf'];
    _telefone = obj['telefone'];
    _bairro = obj['bairro'];
    _cep = obj['CEP'];
    _rua = obj['rua'];
    _numero = obj['numero'];
  }
}
