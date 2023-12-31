import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';
import 'package:projeto_coleta_seletiva/Telas/Denuncia/TelaDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Telas/Login.dart';
import 'package:projeto_coleta_seletiva/Telas/Solicitacoes/VisualizarSolicitacoes.dart';
import 'package:projeto_coleta_seletiva/Telas/ChatBot/ChatBot.dart';

class Menu extends StatefulWidget {
  final Usuario usuario;
  Menu({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState(usuario: usuario);
}

class _MenuState extends State<Menu> {
  final Usuario usuario;

  _MenuState({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.asset('assets/seletinhoHomePage.png'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaDenuncia(usuario: usuario),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'DENÚNCIAS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBot()),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'CHAT DÚVIDAS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VisualizarSolicitacoesTest(usuario: usuario),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'HISTÓRICO DE SOLICITAÇÕES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  'Sair',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
