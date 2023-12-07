import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/DenunciaDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';

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
                onPressed: () async {
                  DenunciaDAOImpl denunciaDAOImpl = DenunciaDAOImpl();
                  List<Denuncia> listaDenuncias =
                      await denunciaDAOImpl.listarDenuncias(usuario);
                  Denuncia d = listaDenuncias.first;
                  //ignore: avoid_print
                  print("${d.tipoDenuncia}, Descrição: ${d.descricaoDenuncia}");

                  setState(() {
                    denuncias = listaDenuncias;
                  });
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
              ListaDenunciasWidget(denuncias: denuncias), ////aq

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

class ListaDenunciasWidget extends StatelessWidget {
  final List<Denuncia> denuncias;

  ListaDenunciasWidget({required this.denuncias});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Defina a altura conforme necessário
      child: ListView.builder(
        itemCount: denuncias.length,
        itemBuilder: (context, index) {
          Denuncia denuncia = denuncias[index];

          return Card(
            // Customize the appearance of each card as needed
            child: ListTile(
              title: Text('Tipo: ${denuncia.tipoDenuncia?.toCustomString()}'),
              subtitle: Text('Descrição: ${denuncia.descricaoDenuncia}'),
              // Add more information as needed
            ),
          );
        },
      ),
    );
  }
}
