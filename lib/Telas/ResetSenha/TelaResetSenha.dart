import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';

class TelaResetSenha extends StatefulWidget {
  TelaResetSenha({Key? key})
      : super(key: key); // Construtor que recebe o usuário como parâmetro

  @override
  State<TelaResetSenha> createState() => _TelaResetSenhaState();
}

class _TelaResetSenhaState extends State<TelaResetSenha> {
  String email = "";
  String senha = "";
  bool mostrarCampoSenha = false;
  bool _senhaVisivel = false;
  String textoBotao = 'VERIFICAR E-MAIL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Resetar Senha",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          centerTitle: true, // Centraliza o título na AppBar
          backgroundColor:
              Colors.transparent, // Defina a cor de fundo como transparente
          flexibleSpace: Container(
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
          ),
          leading: GestureDetector(
            onTap: () {
              // Ação quando qualquer parte do container é clicada
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            //Controlar margem
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Tipo de denuncia
                const Text(
                  'E-mail da conta:',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 5),

                //Descrever denuncia
                TextFormField(
                  onChanged: (text) {
                    email = text;
                  },
                  style: const TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Por favor, insira o e-mail';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //SENHA
                //Mostrar campo de senha apenas se mostrarCampoSenha for true
                if (mostrarCampoSenha)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Nova Senha:',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        obscureText: !_senhaVisivel,
                        onChanged: (text) {
                          senha = text;
                        },
                        style: const TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _senhaVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black38,
                            ),
                            onPressed: () {
                              setState(() {
                                _senhaVisivel = !_senhaVisivel;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Por favor, insira a senha';
                          }
                          return null;
                        },
                      ),
                    ],
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
                    _vericarEmailExiste();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, //Defina a cor de fundo como transparente
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), //Ajuste o raio conforme necessário
                    ),
                  ),
                  child: Text(
                    textoBotao,
                    style: const TextStyle(
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
      ),
    );
  }

  void _vericarEmailExiste() async {
    //Verificar se o input ta correto
    //Teste para formatação do E-MAIL
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!regex.hasMatch(email)) {
      popUpEmailErro();

      return;
    }

    UsuarioDAOImpl usuarioDao = UsuarioDAOImpl();

    if (mostrarCampoSenha == false) {
      //Encontra o usuario com aquele email
      bool usuarioExiste = await usuarioDao.verificarUsuarioExistente(email);

      if (usuarioExiste) {
        setState(() {
          mostrarCampoSenha = true;
          textoBotao = "RESETAR SENHA";
        });
      } else {
        popUpErro(); //Se o e-mail nao foi achado

        return;
      }
    } else {
      if (senha.isNotEmpty) {
        _resetSenha(email, senha, usuarioDao);
      } else {
        popUpErroSenha();
      }
    }
  }

  void _resetSenha(String email, String novaSenha, UsuarioDAOImpl usuarioDao) {
    usuarioDao.resetSenha(email, novaSenha);

    Navigator.pop(context);
  }

  Future popUpEmailErro() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "E-Mail não formatado corretamente.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "OK",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );

  Future popUpErroSenha() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Por favor insira a nova senha.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "OK",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );

  Future popUpErro() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Conta não encontrada para este e-mail.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "OK",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
}
