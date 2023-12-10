import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/AgendamentoDAOImpl.dart';

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
    _buscarAgendamentos();
  }

  Future<void> _buscarAgendamentos() async {
    AgendamentoDAOImpl agendamentoDAOImpl = AgendamentoDAOImpl();
    List<Agendamento> listaAgendamentos =
        await agendamentoDAOImpl.listarAgendamentos(usuario);

    setState(() {
      agendamentos = listaAgendamentos;
    });
  }

  Future<void> _excluirAgendamento(Agendamento agendamento) async {
    AgendamentoDAOImpl agendamentoDAOImpl = AgendamentoDAOImpl();

    bool confirmarExclusao = await _mostrarDialogoConfirmacao();

    if (confirmarExclusao) {
      // Exclui o agendamento do banco de dados
      await agendamentoDAOImpl.remover(agendamento);

      // Atualiza o estado para refletir que a linha seja removida da lista
      setState(() {
        agendamentos.remove(agendamento);
      });
    }
  }

  Future<dynamic> _mostrarDialogoConfirmacao() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          content: Text('Deseja mesmo cancelar o agendamento?',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          backgroundColor: Colors.green,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancela a exclusão
              },
              child: const Text('Não',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma a exclusão
              },
              child: const Text('Sim',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Agendamentos',
            style: TextStyle(
              color: Colors.white,
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
        body: Container(
          width: double.infinity, // Ocupa toda a largura da tela
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              if (agendamentos.isEmpty)
                Text(
                  'Nenhum agendamento encontrado.',
                  style: TextStyle(
                    fontSize: 16,
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
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Data do agendamento: ${agendamento.dataAgendamentoFormatada()}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _excluirAgendamento(agendamento);
                            },
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
