import 'package:projeto_coleta_seletiva/Telas/ChatBot/ChatBot.dart';
import 'package:flutter/material.dart';

class InfoChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seletinho - Chatbot'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao Seletinho!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 140,
              height: 140,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset("assets/seletinhoHomePage.png"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'O Seletinho está aqui para te ajudar com informações sobre coleta seletiva e ecopontos. Ele pode responder a perguntas como:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Quais tipos de materiais são aceitos na coleta seletiva?',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Como posso fazer denúncias relacionadas à coleta seletiva?',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Qual é o prazo para o atendimento dos agendamentos de serviço?',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '4. Quais são os horários de funcionamento dos ecopontos?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Como posso te ajudar hoje?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Botão para iniciar a conversa com o chatbot
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBot()),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'Conversar com Seletinho',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
