import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Controller/AtualizarContaController.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class AlterarDados extends StatefulWidget {
  final Usuario? usuario;

  AlterarDados({required this.usuario});

  @override
  _AlterarDadosState createState() => _AlterarDadosState();
}

class _AlterarDadosState extends State<AlterarDados> {
  final AtualizarContaController _controller = AtualizarContaController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Preencher os campos com os dados atuais do usuário
    _telefoneController.text = widget.usuario?.telefone ?? '';
    _emailController.text = widget.usuario?.email ?? '';
    _cepController.text = widget.usuario?.cep ?? '';
    _bairroController.text = widget.usuario?.bairro ?? '';
    _ruaController.text = widget.usuario?.rua ?? '';
    _numeroController.text = widget.usuario?.numero ?? '';
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Novo Telefone'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Novo Email'),
            ),
            TextField(
              controller: _cepController,
              decoration: InputDecoration(labelText: 'Novo CEP'),
            ),
            TextField(
              controller: _bairroController,
              decoration: InputDecoration(labelText: 'Novo Bairro'),
            ),
            TextField(
              controller: _ruaController,
              decoration: InputDecoration(labelText: 'Nova Rua'),
            ),
            TextField(
              controller: _numeroController,
              decoration: InputDecoration(labelText: 'Novo Número'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Verificar se todos os campos não são null
                if (_telefoneController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _cepController.text.isNotEmpty &&
                    _bairroController.text.isNotEmpty &&
                    _ruaController.text.isNotEmpty &&
                    _numeroController.text.isNotEmpty) {
                  // Criando um novo usuário com os dados atualizados
                  Usuario novoUsuario = Usuario.fromMap({
                    'idUsuario': widget.usuario?.idUsuario,
                    'nome': widget.usuario?.nome,
                    'senha': widget.usuario?.senha,
                    'cpf': widget.usuario?.cpf,
                    'telefone': _telefoneController.text,
                    'email': _emailController.text,
                    'CEP': _cepController.text,
                    'bairro': _bairroController.text,
                    'rua': _ruaController.text,
                    'numero': _numeroController.text,
                  });

                  await _controller.at(novoUsuario); //atualização

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Dados atualizados com sucesso!'),
                    ),
                  );
                } else {
                  // Exibir mensagem ou tratar quando algum campo obrigatório estiver vazio
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Preencha todos os campos obrigatórios!'),
                    ),
                  );
                }
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
