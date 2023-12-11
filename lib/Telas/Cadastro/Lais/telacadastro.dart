//import 'package: UI';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';

import '../../../Models/Usuario.dart';

/*class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Cadastro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
               ),),
            ),
        ),
        body: MyForm(),
      ),
    );
  }
}*/

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  //const Cadastro({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mask = MaskTextInputFormatter(mask: '(##)# ####-####');
    var maskCep = MaskTextInputFormatter(mask: '#####-###');
    var maskCPF = MaskTextInputFormatter(mask: '###.###.###-##');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Cadastro',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        /* image: const DecorationImage(
                          image: AssetImage('assets/seletinhoHomePage.png'),
                          fit: BoxFit.cover,
                        ),*/
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _cpfController,
                    inputFormatters: [maskCPF],
                    decoration: InputDecoration(
                      labelText: 'CPF',
                      hintText: '999.999.999-99',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu CPF';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _telefoneController,
                    inputFormatters: [mask],
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      hintText: '(99)9 9999-9999',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu Telefone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // print('onSaved - Nome: $value');
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _ruaController,
                    decoration: InputDecoration(
                      labelText: 'Rua',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu o nome da sua Rua';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _numeroController,
                    decoration: InputDecoration(
                      labelText: 'Número',
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
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _bairroController,
                    decoration: InputDecoration(
                      labelText: 'Bairro',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome do seu Bairro';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _cepController,
                    inputFormatters: [maskCep],
                    decoration: InputDecoration(
                      labelText: 'CEP',
                      hintText: '99999-999',
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
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // print('onSaved - Nome: $value');
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua Senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        String nome = _nomeController.text;
                        String cpf = _cpfController.text;
                        String telefone = _telefoneController.text;
                        String rua = _ruaController.text;
                        String numero = _numeroController.text;
                        String bairro = _bairroController.text;
                        String cep = _cepController.text;
                        String email = _emailController.text;
                        String senha = _senhaController.text;

                        Usuario novoUsuario = Usuario(
                          nome: nome,
                          cpf: cpf,
                          telefone: telefone,
                          rua: rua,
                          numero: numero,
                          bairro: bairro,
                          cep: cep,
                          email: email,
                          senha: senha,
                        );

                        UsuarioDAOImpl dao = UsuarioDAOImpl();
                        dao.salvarUsuario(novoUsuario);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuário cadastrado com sucesso!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Center(
                      child: Text('Enviar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
