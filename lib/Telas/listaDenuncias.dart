import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class ListaDenunciasWidget extends StatelessWidget {
  final List<Denuncia> denuncias;
  final Usuario usuario;

  ListaDenunciasWidget({required this.denuncias, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: denuncias.length,
        itemBuilder: (context, index) {
          Denuncia denuncia = denuncias[index];

          return Card(
            child: ListTile(
              title: Text('Tipo: ${denuncia.tipoDenuncia?.toCustomString()}'),
              subtitle: Text('Descrição: ${denuncia.descricaoDenuncia}'),
            ),
          );
        },
      ),
    );
  }
}
