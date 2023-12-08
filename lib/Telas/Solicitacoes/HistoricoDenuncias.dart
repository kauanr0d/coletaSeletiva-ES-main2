import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/DenunciaDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';

class HistoricoDenuncias extends StatefulWidget {
  final Usuario usuario;

  HistoricoDenuncias({Key? key, required this.usuario});

  @override
  State<HistoricoDenuncias> createState() =>
      _VisualizarSolicitacoesState(usuario: usuario);
}

class _VisualizarSolicitacoesState extends State<HistoricoDenuncias> {
  List<Denuncia> denuncias = [];
  final Usuario usuario;

  _VisualizarSolicitacoesState({required this.usuario});

  @override
  void initState() {
    super.initState();
    _buscarDenuncias();
  }

  Future<void> _buscarDenuncias() async {
    DenunciaDAOImpl denunciaDAOImpl = DenunciaDAOImpl();
    List<Denuncia> listaDenuncias =
        await denunciaDAOImpl.listarDenuncias(usuario);

    setState(() {
      denuncias = listaDenuncias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Histórico De Denúncias',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
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
        body: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de Denúncias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              if (denuncias.isEmpty)
                Text(
                  'Nenhuma denúncia encontrada.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: denuncias.length,
                    itemBuilder: (context, index) {
                      Denuncia denuncia = denuncias[index];

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                            'Tipo: ${denuncia.tipoDenuncia?.toCustomString()}',
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descrição: ${denuncia.descricaoDenuncia}',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Data da Denúncia: ${denuncia.dataDenunciaFormatada()}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
