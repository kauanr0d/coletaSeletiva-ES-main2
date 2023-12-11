import 'package:flutter/material.dart';
import 'package:projeto_coleta_seletiva/Telas/ChatBot/TesteRasaService.dart';
import 'package:projeto_coleta_seletiva/Telas/ChatBot/AjusteTelaChat.dart'; // Importa o widget ChatMessage() -- ajusta as mensagens da tela

//classe principal do chat(FAZ A CONEXAO COM O CLOUD E TEM A ESTRUTURA BASICA DA TELA)
class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ScrollController _scrollController = ScrollController();
  final RasaService _rasaService = RasaService('http://34.95.148.245:5005');
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();

  _sendMessage(String text) async {
    _textController.clear();
    setState(() {
      _messages.add('Você: $text');
    });

    final response = await _rasaService.sendMessage(text);
    setState(() {
      _messages.add('Bot: $response');
    });

    // Aguarde um pequeno atraso antes de rolar para garantir que a lista seja reconstruída
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat Bot",
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message
                    .startsWith('Bot: '); // Verifica se é uma mensagem do bot
                return ChatMessage(
                  text: message,
                  isBot: isBot,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: "Enviar mensagem"),
                    style: TextStyle(fontSize: 18),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textController.text);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
