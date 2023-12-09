import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/AgendamentoDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Interfaces/AgendamentoDAO.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';

class TelaAgendamento extends StatefulWidget {
  final Usuario usuario;

  TelaAgendamento({Key? key, required this.usuario}) : super(key: key);

  @override
  State<TelaAgendamento> createState() =>
      _TelaAgendamentoState(usuario: usuario);
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final AgendamentoDAO agendamentoDAO = AgendamentoDAOImpl();
  final Usuario usuario;

  _TelaAgendamentoState({required this.usuario});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _descricao = TextEditingController();
  DateTime? _selecaoData;
  List<TipoAgendamento> _selecaoTiposAgendamento = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Agendamento',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/seletinhoHomePage.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Descricao do Agendamento
                  TextFormField(
                    controller: _descricao,
                    decoration: InputDecoration(
                      labelText: 'Descrição do Agendamento',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma descrição';
                      }
                      return null;
                    },
                  ),

                  //Data de Coleta
                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      _selecionarData(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Data de Coleta: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          if (_selecaoData != null)
                            Text(
                              '${_selecaoData!.day}/${_selecaoData!.month}/${_selecaoData!.year}',
                            ),
                        ],
                      ),
                    ),
                  ),

                  //Tipos De Residuos
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Tipos de Resíduos',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      children: TipoAgendamento.values
                          .map(
                            (tipo) => RadioListTile(
                              title: Text(
                                tipo.toString().split('.').last,
                                style: const TextStyle(fontSize: 16),
                              ),
                              value: tipo,
                              groupValue: _selecaoTiposAgendamento.isNotEmpty
                                  ? _selecaoTiposAgendamento[0]
                                  : null,
                              onChanged: (TipoAgendamento? value) {
                                setState(() {
                                  _selecaoTiposAgendamento.clear();
                                  if (value != null) {
                                    _selecaoTiposAgendamento.add(value);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Exibir os resíduos selecionados
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 249, 250, 249),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Resíduo Selecionado: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selecaoTiposAgendamento.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _selecaoTiposAgendamento[index]
                                        .toString()
                                        .split('.')
                                        .last,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Color.fromARGB(255, 68, 202, 255),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _salvarFormulario();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'AGENDAR COLETA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selecaoData) {
      setState(() {
        _selecaoData = pickedDate;
      });
    }
  }

  void _salvarFormulario() async {
    if (_selecaoTiposAgendamento.isNotEmpty) {
      //TODO: Corrigir construtor de agendamento, corrigir codigo e tirar o comentario.
      final agendamento = Agendamento(
        _selecaoTiposAgendamento[0],
        _descricao.text,
        0,
        _selecaoData ?? DateTime.now(),
      );
      //ignore: avoid_print
      print(agendamento.tipoAgendamento.toString());
      await agendamentoDAO.salvarAgendamento(agendamento, usuario);

      //Navigator.pop(context);
      // agendamentoDAO.salvarAgendamento(agendamento, usuario);

      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: const Text('Selecione pelo menos um tipo de resíduo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
