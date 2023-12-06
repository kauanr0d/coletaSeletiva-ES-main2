import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_coleta_seletiva/InputFormatter/CepInputFormatter.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/InputFormatter/CpfInputFormatter.dart';
import 'package:projeto_coleta_seletiva/Models/Endereco.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class TelaCadastro extends StatelessWidget {
  TelaCadastro({super.key});

  Endereco endereco = Endereco("", "", 0, "");
  String nome = "";
  String sobrenome = "";
  String senha = "";
  String cpf = "";
  String telefone = "";
  String email = "";

  TextEditingController cpfController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cadastrar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true, // Centraliza o título na AppBar
        backgroundColor: Colors.green,
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
      body: Padding(
        //Controlar margem
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Nome
            TextField(
              onChanged: (text) {
                nome = text;
              },
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                    RegExp(r'[0-9]')), // Impede a entrada de números
              ],
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                filled: true,
                fillColor: Color.fromARGB(255, 243, 243, 243),
                labelText: 'Nome:',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 20),
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),

            //Sobrenome
            TextField(
              onChanged: (text) {
                sobrenome = text;
              },
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                filled: true,
                fillColor: Color.fromARGB(255, 243, 243, 243),
                labelText: 'Sobrenome:',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 20),
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),

            //E-MAIL
            TextField(
              onChanged: (text) {
                email = text;
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                filled: true,
                fillColor: Color.fromARGB(255, 243, 243, 243),
                labelText: 'E-Mail:',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 20),
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),

            //CPF
            TextField(
              controller: cpfController,
              onChanged: (text) {
                text = text.replaceAll(
                    RegExp(r'[^\d]'), ''); // Remover caracteres não numéricos

                if (text.length > 3 && text.substring(3, 4) != '.') {
                  text = "${text.substring(0, 3)}.${text.substring(3)}";
                }

                if (text.length > 7 && text.substring(7, 8) != '.') {
                  text = "${text.substring(0, 7)}.${text.substring(7)}";
                }

                if (text.length > 11 && text.substring(11, 12) != '-') {
                  text = "${text.substring(0, 11)}-${text.substring(11)}";
                }

                cpfController.value = cpfController.value.copyWith(
                  text: text,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: text.length),
                  ),
                );

                cpf = cpfController.text;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                CpfInputFormatter(), // Formatter customizado para formatar o CPF
              ],
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                filled: true,
                fillColor: Color.fromARGB(255, 243, 243, 243),
                labelText: 'CPF:',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 20),
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),

            //SENHA
            TextField(
              onChanged: (text) {
                senha = text;
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                filled: true,
                fillColor: Color.fromARGB(255, 243, 243, 243),
                labelText: 'Senha:',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 20),
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),

            //ENDEREÇO
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
                    disabledBackgroundColor: Colors.green
                        .withOpacity(0.12), // Cor do texto ao ser pressionado
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
                    popUpGoogleMaps(context);
                  },
                ),
              ],
            ),

            //Enviar cadastro
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _vericarInput(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'CADASTRAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _vericarInput(BuildContext context) {
    if (nome.isEmpty ||
        sobrenome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        cpf.isEmpty ||
        (endereco.bairro.isEmpty ||
            endereco.rua.isEmpty ||
            endereco.rua.isEmpty ||
            endereco.cep.length < 8)) {
      popUpErro(context);

      return;
    }

    //Poderia ter outros if para verificar se a formatação dos campos ta correta
    //Ex: senha > n digitos ou contem letra maiuscula, etc
    //Teste para formatação do E-MAIL
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!regex.hasMatch(email)) {
      popUpEmailErro(context);

      return;
    }

    _cadastrarUsuario(context);
  }

  void _cadastrarUsuario(BuildContext context) {
    //TODO: Criar instancia de usuario, inserir os dados e chamar o BD
    //Unir nome e sobrenome
    String nomeCompleto = "$nome $sobrenome";

    //if que verifica se funcionou
    popUpSucessoCadastro(context);
    //se não funcionou
    //popUpFalhaCadastro(context);
  }

  Future popUpSucessoCadastro(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "Sucesso",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Cadastro realizado com sucesso.",
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

  Future popUpFalhaCadastro(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Ocorreu uma falha ao efetuar o cadastro.",
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

  Future popUpErro(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Dados não suficientes para cadastrar.",
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

  Future popUpEmailErro(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            "ERRO",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "E-Mail não formatado corretamente.",
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

  Future popUpGoogleMaps(BuildContext context) => showDialog(
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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Bairro do local:',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 20),
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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Rua do local:',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 20),
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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromARGB(255, 243, 243, 243),
                    labelText: 'Número do local:',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 20),
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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromARGB(255, 243, 243, 243),
                    labelText: 'CEP do local:',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 20),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
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
