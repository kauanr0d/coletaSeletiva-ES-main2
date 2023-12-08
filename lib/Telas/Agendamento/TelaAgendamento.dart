import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_coleta_seletiva/InputFormatter/CepInputFormatter.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/AgendamentoDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Interfaces/AgendamentoDAO.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';

class TelaAgendamento extends StatefulWidget {
  final Usuario usuario;

  TelaAgendamento({Key? key, required this.usuario}) : super(key: key);

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState(usuario: usuario);
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final AgendamentoDAO agendamentoDAO = AgendamentoDAOImpl();
  final Usuario usuario;

  _TelaAgendamentoState({required this.usuario});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _bairro = TextEditingController();
  TextEditingController _rua = TextEditingController();
  TextEditingController _numero = TextEditingController();
  TextEditingController _cep = TextEditingController();
  DateTime? _selectedDate;
  List<TipoAgendamento> _selecaoTiposAgendamento = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Agendamento',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
            ),
          ),
          backgroundColor: Colors.green, centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
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
                  TextFormField(
                    controller: _bairro,
                    decoration: const InputDecoration(
                      labelText: 'Bairro',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o bairro';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _rua,
                    decoration: const InputDecoration(
                      labelText: 'Rua',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a rua';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _numero,
                    decoration: const InputDecoration(
                      labelText: 'Número (Opcional)',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
TextFormField(
                    controller: _cep,
                    onChanged: (text) {
                      text = text.replaceAll(RegExp(r'[^\d]'),
                          ''); // Remover caracteres não numéricos

                      if (text.length > 5 && text.substring(5, 6) != '-') {
                        text = "${text.substring(0, 5)}-${text.substring(5)}";
                      }

                      _cep.value = _cep.value.copyWith(
                        text: text,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: text.length),
                        ),
                      );
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      CepInputFormatter(), // Formatter customizado para formatar o CEP
                    ],
                    decoration: const InputDecoration(
                      labelText: 'CEP (Opcional)',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      _selecionarData(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 233, 228),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Data de Coleta: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          if (_selectedDate != null)
                            Text(
                              '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              //style: TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 228, 233, 228),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
                            (tipo) => CheckboxListTile(
                              title: Text(
                                tipo.toString().split('.').last,
                                style: const TextStyle(fontSize: 16),
                              ),
                              value: _selecaoTiposAgendamento.contains(tipo),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null) {
                                    if (value) {
                                      _selecaoTiposAgendamento.add(tipo);
                                    } else {
                                      _selecaoTiposAgendamento.remove(tipo);
                                    }
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Resíduos Selecionados: ${_selecaoTiposAgendamento.map((tipo) => tipo.toString().split('.').last).join(', ')}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _submeterFormulario();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: const Size(double.infinity, 40), // Ajusta o tamanho do botão
                    ),
                    child: const Text(
                      'Agendar Coleta',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submeterFormulario() {
    final endereco = Endereco(
      _bairro.text,
      _rua.text,
      int.tryParse(_numero.text) ?? 0,
      _cep.text,
    );

    if (_selecaoTiposAgendamento.isNotEmpty) {
      /*TODO: Corrigir construtor de agendamento, corrigir o codigo e tirar o comentario
      final agendamento = Agendamento(
        _selecaoTiposAgendamento[0],
        'Descrição do Agendamento',
        0,
        DateTime.now(),
        endereco: endereco,
        tiposAgendamento: _selecaoTiposAgendamento,
        usuario: usuario,
        dataAgendamento: _selectedDate,
      );

      agendamentoDAO.salvarAgendamento(agendamento, usuario);*/

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
