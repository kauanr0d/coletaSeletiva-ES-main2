import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class MeusDados extends StatelessWidget {
  final Usuario? usuario;

  MeusDados({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Dados',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
        padding: EdgeInsets.all(16.0),
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
            buildInfo('Nome:', usuario?.nome),
            buildInfo('Email:', usuario?.email),
            buildInfo('CPF:', usuario?.cpf),
            buildInfo('Telefone:', usuario?.telefone),
            buildInfo('Bairro:', usuario?.bairro),
            buildInfo('Rua:', usuario?.rua),
            buildInfo('Número:', usuario?.numero),
            buildInfo('CEP:', usuario!.cep),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        Text(
          value ?? 'Não disponível',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
