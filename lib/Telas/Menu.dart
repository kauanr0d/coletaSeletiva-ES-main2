import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Telas/Agendamento/TelaAgendamento.dart';
import 'package:projeto_coleta_seletiva/Telas/Denuncia/TelaDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Telas/Login.dart';
import 'package:projeto_coleta_seletiva/Telas/Meu%20Perfil/Perfil.dart';
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

  //Widget de gradiente de Kauan
  Widget _buildGradientButton(
      {required String text, required VoidCallback onPressed}) {
    return Container(
      width: 300.0,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0), // Ajustado para 25
        gradient: const LinearGradient(
          colors: [
            Colors.green,
            Color.fromARGB(255, 68, 202, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent, // Cor do texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0), // Ajustado para 25
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/seletinhoHomePage.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGradientButton(
                  text: 'AGENDAR COLETA',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaAgendamento(usuario: usuario),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildGradientButton(
                  text: 'DENUNCIAR',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDenuncia(usuario: usuario),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildGradientButton(
                  text: 'CHAT DÚVIDAS',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatBot(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildGradientButton(
                  text: 'MEU PERFIL',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Perfil(usuario: usuario),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildGradientButton(
                  text: 'HISTÓRICO DE SOLICITAÇÕES',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VisualizarSolicitacoesTest(usuario: usuario),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: TextButton(
                child: const Text(
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
