import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Telas/Solicitacoes/HistoricoDenuncias.dart';
import 'package:projeto_coleta_seletiva/Telas/Solicitacoes/HistoricoAgendamentos.dart';

class VisualizarSolicitacoesTest extends StatefulWidget {
  final Usuario usuario;

  VisualizarSolicitacoesTest({Key? key, required this.usuario})
      : super(key: key);

  @override
  State<VisualizarSolicitacoesTest> createState() =>
      _VisualizarSolicitacoesState();
}

class _VisualizarSolicitacoesState extends State<VisualizarSolicitacoesTest> {
  List<Denuncia> denuncias = [];

  @override
  void initState() {
    super.initState();
    // Lógica de inicialização aqui, se necessário
  }

  Widget _buildGradientButton(
      {required String text, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
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
          primary: Colors.transparent, // Cor de fundo transparente
          onPrimary: Colors.white, // Cor do texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Histórico De Solicitações',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          flexibleSpace: Container(
            decoration: BoxDecoration(
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGradientButton(
                text: 'VISUALIZAR DENÚNCIAS',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoricoDenuncias(usuario: widget.usuario),
                    ),
                  );
                },
              ),

              SizedBox(height: 16), // Espaçamento entre os botões

              _buildGradientButton(
                text: 'VISUALIZAR AGENDAMENTOS',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoricoAgendamento(usuario: widget.usuario),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
