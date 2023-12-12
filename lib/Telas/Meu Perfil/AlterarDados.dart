import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_coleta_seletiva/Controller/AtualizarContaController.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
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
    String emailAtual = widget.usuario?.email ?? '';

    var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
    var maskCep = MaskTextInputFormatter(mask: '#####-###');
    var maskCPF = MaskTextInputFormatter(mask: '###.###.###-##');

    return Scaffold(
      appBar: AppBar(
        // Define a barra superior do aplicativo
        title: const Text(
          'Alterar Dados',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          // botão voltar
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        flexibleSpace: Container(
          // designer da barra superior
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Color.fromARGB(255, 68, 202, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _telefoneController,
                inputFormatters: [mask],
                decoration: InputDecoration(
                  labelText: 'Novo Telefone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu telefone';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Novo E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cepController,
                inputFormatters: [maskCep],
                decoration: InputDecoration(
                  labelText: 'Novo CEP',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CEP do seu Endereço';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _bairroController,
                decoration: InputDecoration(
                  labelText: 'Novo Bairro',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do seu bairro';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ruaController,
                decoration: InputDecoration(
                  labelText: 'Nova Rua',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu o nome da sua rua';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(
                  labelText: 'Novo Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número da sua residência';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Color.fromARGB(255, 68, 202, 255),
                ], // Cores do gradiente
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _vericarInput(emailAtual);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, //Defina a cor de fundo como transparente
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), //Ajuste o raio conforme necessário
                  ),
                ),
                child: const Text(
                  'ATUALIZAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _vericarInput(String emailAtual) async {
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

      RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
      if (!regex.hasMatch(_emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail formatado incorretamente!'),
          ),
        );

        return;
      }

      UsuarioDAOImpl usuarioDao = UsuarioDAOImpl();

      bool usuarioExiste =
          await usuarioDao.verificarUsuarioExistente(_emailController.text);

      //Verifica se o usuario mudou o email e se o novo email ja existe
      if (usuarioExiste && emailAtual != _emailController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Já existe um usúario com este e-mail!'),
          ),
        );
        return;
      }

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
  }
}
