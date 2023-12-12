import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoAgendamento.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/AgendamentoDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Interfaces/AgendamentoDAO.dart';
import 'package:projeto_coleta_seletiva/Models/Agendamento.dart';

// Criação da Classe TelaAgendamento, que extends a o widget StatefulWidget(possui estado mutavel)
class TelaAgendamento extends StatefulWidget {
  final Usuario usuario;

  TelaAgendamento({Key? key, required this.usuario})
      : super(
            key:
                key); //Construtor da classe, recebe o usuario(required) e uma chave

  // Cria e retorna uma instancia do estado associado a instancia de TelaAgndamento
  @override
  State<TelaAgendamento> createState() =>
      _TelaAgendamentoState(usuario: usuario);
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final AgendamentoDAO agendamentoDAO = AgendamentoDAOImpl();
  final Usuario usuario;

  _TelaAgendamentoState(
      {required this.usuario}); // Construtor da classe e exige o objeto Usuario(Required)
  //_formKey é a chave usada para manipular o estado do formulário, como validação e redefinição.
  final _formKey = GlobalKey<FormState>();

  TextEditingController _descricao =
      TextEditingController(); //Controlador que será usado no campo de texto no formulario
  DateTime? _selecaoData; //Variavel que armazenará a Data
  List<TipoAgendamento> _selecaoTiposAgendamento =
      []; // Declaração de uma lista, usada para selecionar os tipos de agendamento

  // Construção da tela de interface da tela agendamento usando o Framework flutter
  @override
  Widget build(BuildContext context) {
    //utilzado para construir a hierarquia de widgets
    return MaterialApp(
      // Widget que configura a estrutura basica do aplicativo(Temas, navegação)
      home: Scaffold(
        appBar: AppBar(
          // Define a barra superior do aplicativo
          title: const Text(
            'Agendamento',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          leading: Padding(
            // botão voltar
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          flexibleSpace: Container(
            // designer da barra superior
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
          //Widget que permite rolar a tela
          child: Padding(
            padding: const EdgeInsets.all(
                16.0), // Espaçamento uniforme de todos os lados
            child: Form(
              // Widget utilizado para crir formulario e validar
              key: _formKey,
              child: Column(
                // Widget que organiza os widgets filhos na vertical
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Especifica uma lista de widgets filhos
                  const SizedBox(
                      height: 16), // Adiciona espaçamneto entre s widgets
                  Center(
                    child: Container(
                      //utilizado para contér  a imagem da tela
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        // decorar a imagem
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
                  const SizedBox(height: 16), // Espaçamento

                  // Descricao do Agendamento
                  TextFormField(
                    // Widget utlizado para criar um campo de texto para entrada de dados
                    controller: _descricao,
                    decoration: InputDecoration(
                      // Aparência do campo de texto
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

                  const SizedBox(height: 16), // espaçamento

                  //Data de Coleta
                  GestureDetector(
                    // Widget que detectar gestos
                    onTap: () {
                      // Com base no toque dá tela
                      _selecionarData(context);
                    },
                    child: Container(
                      // Widget retangular que armazenrá a data após seleção
                      padding: const EdgeInsets.all(
                          16), // Espaçamento interno no retangulo
                      decoration: BoxDecoration(
                        // Defini a aparencia do retangulo
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        // Widget que serve para organizar o conteudo no retangulo
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Data de Coleta: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          if (_selecaoData !=
                              null) // Exibi a data se for diferente de null
                            Text(
                              '${_selecaoData!.day}/${_selecaoData!.month}/${_selecaoData!.year}',
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  //Tipos De Residuos
                  Container(
                    // Recipiente retangular para aplicar estilos
                    decoration: BoxDecoration(
                      // Definiçãoo da decoração do retangulo
                      color: Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: ExpansionTile(
                      // Widget que cria um bloco expansivel quando clicado
                      title: const Text(
                        'Tipos de Resíduos',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      children: TipoAgendamento
                          .values // Pega os tipos de Agendamentos e coloca dentro de uma lista RadioListTile
                          .map(
                            (tipo) => RadioListTile(
                              // Widget que apresenta varios itens com possibilidade de apenas uma seleção
                              title: Text(
                                tipo.toString().split('.').last,
                                style: const TextStyle(fontSize: 16),
                              ),
                              value: tipo,
                              groupValue: _selecaoTiposAgendamento.isNotEmpty
                                  ? _selecaoTiposAgendamento[0]
                                  : null,
                              onChanged: (TipoAgendamento? value) {
                                //(Atualiza o estado) Funçao de retorno que é chamada quando o usuario seleciona um item
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
                  const SizedBox(height: 16), // espaçamento

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
                        // Lista de Widgets que são emmpilhados na vertical
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
                          // Conteiner que contem o tipo de residuo
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selecaoTiposAgendamento.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // Exibir o item selecionado
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

        //Botão agendar coleta
        bottomNavigationBar: Padding(
          //Adiciona um preenchimento (espaço em branco)  ao redor do conteúdo dentro do bottomNavigationBar
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              decoration: const BoxDecoration(
                // Visual do Botão
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
                // difinir altura
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Se valido, chama a função
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
      final agendamento = Agendamento(
        _selecaoTiposAgendamento[0],
        _descricao.text,
        0,
        _selecaoData ?? DateTime.now(),
      );
      //ignore: avoid_print
      print(agendamento.tipoAgendamento.toString());
      agendamentoDAO.salvarAgendamento(agendamento, usuario);
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
