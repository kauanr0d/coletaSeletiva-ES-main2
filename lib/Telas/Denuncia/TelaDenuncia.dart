import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_coleta_seletiva/DAO/DenunciaDAOImpl.dart';
import 'package:projeto_coleta_seletiva/InputFormatter/CepInputFormatter.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';

class TelaDenuncia extends StatefulWidget {
  final Usuario usuario;

  TelaDenuncia({Key? key, required this.usuario})
      : super(key: key); // Construtor que recebe o usuário como parâmetro

  @override
  State<TelaDenuncia> createState() => _TelaDenunciaState(usuario: usuario);
}

class _TelaDenunciaState extends State<TelaDenuncia> {
  final Usuario usuario;
  TipoDenuncia? _selectedTipoDenuncia;
  String descricaoDenuncia = "";
  Endereco endereco = Endereco("", "", 0, "");

  _TelaDenunciaState({required this.usuario});

  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Denúncia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          centerTitle: true, // Centraliza o título na AppBar
          backgroundColor:
              Colors.transparent, // Defina a cor de fundo como transparente
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Color.fromARGB(255, 68, 202, 255),
                ], // Cores do gradiente
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              // Ação quando qualquer parte do container é clicada
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            //Controlar margem
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Tipo de denuncia
                const Text(
                  'Tipo de Denúncia:',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 5),

                SizedBox(
                  height: 50, // Ajuste a altura conforme necessário
                  child: DropdownButton<TipoDenuncia>(
                    value: _selectedTipoDenuncia,
                    items: TipoDenuncia.values.map((tipoDenuncia) {
                      return DropdownMenuItem<TipoDenuncia>(
                        value: tipoDenuncia,
                        child: Text(
                          tipoDenuncia.toCustomString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTipoDenuncia = value;
                      });
                    },
                    hint: const Text(
                      'Selecione o Tipo de Denúncia',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //Descrever denuncia
                const Text(
                  'Tipo de Denúncia:',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 5),

                TextFormField(
                  onChanged: (text) {
                    descricaoDenuncia = text;
                  },
                  maxLines: 5,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //Definir ENDEREÇO denuncia
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        enderecoPopUp(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledForegroundColor: Colors.green.withOpacity(0.38),
                        disabledBackgroundColor: Colors.green.withOpacity(
                            0.12), // Cor do texto ao ser pressionado
                        side: const BorderSide(color: Colors.green),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Endereço',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.map,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        popUpGoogleMaps();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
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
                  ], // Cores do gradiente
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _vericarInput(usuario);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, //Defina a cor de fundo como transparente
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), //Ajuste o raio conforme necessário
                    ),
                  ),
                  child: const Text(
                    'ENVIAR',
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

  void _vericarInput(Usuario usuario) {
    //Verificar se o input ta correto
    //Verifico se tem o bairro e rua, se tiver cep verifica se ta formatado correto
    if (descricaoDenuncia.isEmpty ||
        endereco.bairro.isEmpty ||
        endereco.rua.isEmpty ||
        (endereco.cep.isNotEmpty && endereco.cep.length < 8)) {
      popUpErro();

      return;
    }

    _salvarDenuncia(usuario);
  }

  void _salvarDenuncia(Usuario usuario) {
    //Criar uma instância de DenunciaDAOImpl
    DenunciaDAOImpl denunciaDAO = DenunciaDAOImpl();

    //Criar instancia de denuncia
    Denuncia denuncia = Denuncia(
      _selectedTipoDenuncia,
      descricaoDenuncia,
      0, // Id da denúncia
      DateTime.now(),
      bairro: endereco.bairro,
      cep: endereco.cep,
      rua: endereco.rua,
      numero: endereco.numero.toString(),
    );

    //Chamar o método salvarDenuncia da instância de DenunciaDAO
    denunciaDAO.salvarDenuncia(denuncia, usuario);
    Navigator.pop(context);
  }

  Future popUpGoogleMaps() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "MAPS",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Por falta de verba a funcionalidade de localização usando Google Maps ainda não foi implementada.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "OK",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );

  Future enderecoPopUp(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "Endereço",
            style: TextStyle(color: Colors.white),
          ),
          insetPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              children: [
                // BAIRRO
                TextField(
                  controller: bairroController,
                  onChanged: (text) {
                    endereco.bairro = text;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Bairro:',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 16,
                ),

                // RUA
                TextField(
                  controller: ruaController,
                  onChanged: (text) {
                    endereco.rua = text;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Rua:',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 16,
                ),

                // NUMERO
                TextField(
                  controller: numeroController,
                  onChanged: (text) {
                    //Converter para int
                    endereco.numero = int.parse(text);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], //Aceita apenas dígitos
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Número: (Opcional)',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 16,
                ),

                // CEP
                TextField(
                  controller: cepController,
                  onChanged: (text) {
                    text = text.replaceAll(' ', ''); //Remover espaços em branco

                    endereco.cep = text;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                        8), // Limite para 9 caracteres (incluindo o hífen)
                    CepInputFormatter(), // Formatter customizado para formatar o CEP
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 243, 243, 243),
                    labelText: 'CEP: (Opcional)',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    "FECHAR",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Future popUpErro() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Dados não suficientes para localizar.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "OK",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
}
