import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/DenunciaDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Telas/listaDenuncias.dart'; // Ajuste aqui

class VisualizarSolicitacoes extends StatefulWidget {
  final Usuario usuario;
  VisualizarSolicitacoes({Key? key, required this.usuario});
  @override
  State<VisualizarSolicitacoes> createState() =>
      _VisualizarSolicitacoesState(usuario: usuario);
}

class _VisualizarSolicitacoesState extends State<VisualizarSolicitacoes> {
  List<Denuncia> denuncias = [];
  final Usuario usuario;

  _VisualizarSolicitacoesState({required this.usuario});

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
                      builder: (context) => ListaDenunciasWidget(
                        denuncias: denuncias,
                        usuario: usuario,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Cor do botão
                ),
                child: Text(
                  'Histórico de Denúncias',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        // Outros widgets vão aqui
      ),
    );
  }
}
