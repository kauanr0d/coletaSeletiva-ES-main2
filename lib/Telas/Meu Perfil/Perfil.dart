import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_coleta_seletiva/Controller/DeletarContaController.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/Telas/Login.dart';
import 'package:projeto_coleta_seletiva/Telas/Meu%20Perfil/AlterarDados.dart';
import 'package:projeto_coleta_seletiva/Telas/Meu%20Perfil/MeusDados.dart';
import 'package:projeto_coleta_seletiva/Telas/Solicitacoes/VisualizarSolicitacoes.dart';
import 'package:projeto_coleta_seletiva/Telas/Meu Perfil/MeusDados.dart';

import 'package:image/image.dart' as img;

class Perfil extends StatefulWidget {
  final Usuario usuario;
  Perfil({Key? key, required this.usuario}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState(usuario: usuario);
}

class _PerfilState extends State<Perfil> {
  final Usuario usuario;
  _PerfilState({required this.usuario});

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File croppedImage = await _cropImage(File(pickedImage.path));
      setState(() {
        _image = croppedImage;
      });
    }
  }

  Future<File> _cropImage(File imageFile) async {
    final rawImage = img.decodeImage(await imageFile.readAsBytes());

    final croppedImage = img.copyCrop(
      rawImage!,
      x: 0,
      y: 0,
      width: rawImage.width,
      height: rawImage.height,
    );

    final croppedFile = File('caminho_para_salvar/cropped_image.jpg');
    await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));

    return croppedFile;
  }

  Widget _buildGradientButton(
      {required String text, required VoidCallback onPressed}) {
    return Container(
      width: 300.0,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0), // Ajustado para 25
        gradient: const LinearGradient(
          colors: [
            Colors.green,
            Color.fromARGB(255, 68, 202, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent, // Cor do texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0), // Ajustado para 25
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Column for ID, photo, and username
            Column(
              children: [
                Text(
                  'ID',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: _getImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/default_profile_image.png')
                                as ImageProvider<Object>,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  usuario.nome.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Clique na foto para editar',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
              ],
            ),

            // Spacer
            SizedBox(height: 20),

            // Column for buttons
            Padding(
              padding: EdgeInsets.all(16.0), // Add padding here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGradientButton(
                    text: 'HISTÓRICO DE SOLICITAÇÕES',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VisualizarSolicitacoesTest(usuario: usuario),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildGradientButton(
                    text: 'MEUS DADOS',
                    onPressed: () async {
                      Usuario? usuarioCarregado =
                          await UsuarioDAOImpl().carregarUsuario(usuario);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MeusDados(usuario: usuarioCarregado),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildGradientButton(
                    text: 'ALTERAR DADOS',
                    onPressed: () async {
                      Usuario? usuarioCarregado =
                          await UsuarioDAOImpl().carregarUsuario(usuario);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AlterarDados(usuario: usuarioCarregado),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 300.0,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        _excluirConta();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text(
                        'EXCLUIR CONTA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _excluirConta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Conta'),
          content: Text('Tem certeza de que deseja excluir sua conta?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await DeletarContaController().deletarContaeDados(usuario);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false, // Remover todas as rotas existentes
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
