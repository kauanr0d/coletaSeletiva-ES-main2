import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
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
              'Clique na foto para editar',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VisualizarSolicitacoesTest(usuario: usuario),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'HISTÓRICO DE SOLICITAÇÕES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Usuario? usuarioCarregado = await UsuarioDAOImpl().carregarUsuario(
                    usuario); // Carrega o objeto usuário com os dados atualizados
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MeusDados(
                        usuario:
                            usuarioCarregado), //passando o usuario carregado
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'MEUS DADOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
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
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'ALTERAR DADOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
