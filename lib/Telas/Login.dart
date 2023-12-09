import 'package:projeto_coleta_seletiva/Telas/Cadastro/TelaCadastro.dart';
import 'package:projeto_coleta_seletiva/Controller/LoginController.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Telas/Menu.dart';

import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Telas/ResetSenha/TelaResetSenha.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/seletinhoHomePage.png"),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: senhaController,
              keyboardType: TextInputType.text,
              obscureText:
                  !_senhaVisivel, // Modificado para controlar a visibilidade
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    setState(() {
                      _senhaVisivel = !_senhaVisivel;
                    });
                  },
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              //container para colocar botao em "esqueceu senha"
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text('Esqueceu sua Senha?', textAlign: TextAlign.right),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaResetSenha()),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navega para a página de login quando o botão é pressionado
                // Vai precisar pegar o id do usuario e enviar para a classe menu
                //Modificar para que se o LOGIN esta errado, aparece texto de erro e usuario tenta de novo
                String email = emailController.text;
                String senha = senhaController.text;

                _verificarLogin(email, senha, context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.green), // Altere para a cor desejada
              child: Text('ENTRAR'), // Texto do botão
            ),
            Container(
              //container para colocar botao em "Cadastrar-se"
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                child: Text('Cadastre-se', textAlign: TextAlign.center),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaCadastro()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Metodo de verificar o login do usuario, comparando o email e a senha com o banco de dados
  _verificarLogin(String email, String senha, BuildContext context) async {
    Usuario? usuario = await LoginController().realizarLogin(email, senha);

    if (usuario != null) {
      // Login bem-sucedido
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Menu(usuario: usuario)),
      );
    } else {
      // Exiba uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('E-mail ou senha incorretos'),
        ),
      );
    }
  }
}
