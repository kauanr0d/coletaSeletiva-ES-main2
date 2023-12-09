import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class ListaAgendamentosWidget extends StatelessWidget {
  final List<Agendamento> agendamentos;
  final Usuario usuario;

  ListaAgendamentosWidget({required this.agendamentos, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          Agendamento agendamento = agendamentos[index];
          return Card(
            child: ListTile(
              title: Text(
                  'Tipo: ${agendamento.tipoAgendamento?.toCustomString()}'),
              subtitle: Text('Descrição: ${agendamento.descricaoAgendamento}',
                  style: const TextStyle(fontSize: 14)),
            ),
          );
        },
      ),
    );
  }
}
