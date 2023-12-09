import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/AgendamentoDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';

class HistoricoAgendamento extends StatefulWidget {
  final Usuario usuario;

  HistoricoAgendamento({Key? key, required this.usuario});

  @override
  State<HistoricoAgendamento> createState() =>
      _VisualizarSolicitacoesState(usuario: usuario);
}

class _VisualizarSolicitacoesState extends State<HistoricoAgendamento> {
  List<Agendamento> agendamentos = [];
  final Usuario usuario;

  _VisualizarSolicitacoesState({required this.usuario});

  @override
  void initState() {
    super.initState();
    _buscarDenuncias();
  }

  Future<void> _buscarDenuncias() async {
    AgendamentoDAOImpl agendamentoDAOImpl = AgendamentoDAOImpl();
    List<Agendamento> listaAgendamentos = await agendamentoDAOImpl
        .listarAgendamentos(usuario); //Agendamento.listarDenuncias(usuario);

    setState(() {
      agendamentos = listaAgendamentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Histórico De Agendamentos',
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
                'Lista de Agendamentos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              if (agendamentos.isEmpty)
                Text(
                  'Nenhum agendamento encontrado.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: agendamentos.length,
                    itemBuilder: (context, index) {
                      Agendamento agendamento = agendamentos[index];

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                            'Tipo: ${agendamento.tipoAgendamento?.toCustomString()}',
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descrição: ${agendamento.descricaoAgendamento}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Data do agendamento: ${agendamento.dataAgendamentoFormatada()}',
                                style: TextStyle(fontSize: 12),
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
