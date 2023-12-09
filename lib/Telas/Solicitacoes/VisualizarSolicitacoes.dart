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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoricoDenuncias(usuario: widget.usuario),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text(
                  'VISUALIZAR DENÚNCIAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  // Substitua 'agendamentos' pela sua lista de agendamentos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoricoAgendamento(usuario: widget.usuario),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text(
                  'VISUALIZAR AGENDAMENTOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 16), // Espaçamento entre os botões
              ElevatedButton(
                onPressed: () {
                  // Lógica do segundo botão
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Cor do botão
                ),
                child: Text(
                  'Cancelar Solicitação',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
