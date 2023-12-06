import 'package:flutter/material.dart';

class VisualizarSolicitacoes extends StatefulWidget {
  @override
  _VisualizarSolicitacoesState createState() => _VisualizarSolicitacoesState();
}

class _VisualizarSolicitacoesState extends State<VisualizarSolicitacoes> {
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
                  // Lógica do primeiro botão
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Cor do botão
                ),
                child: Text(
                  'Visualizar Solicitações',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 16), // Espaçamento entre os botões
              ElevatedButton(
                onPressed: () {
                  // Lógica do segundo botão
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.green // Cor do botão
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
        // Outros widgets vão aqui
      ),
    );
  }
}
