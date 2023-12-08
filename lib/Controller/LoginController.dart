import 'package:projeto_coleta_seletiva/DAO/DenunciaDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Denuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Enums/TipoDenuncia.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';
import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';

class LoginController {
  final UsuarioDAOImpl usuarioDAO = UsuarioDAOImpl();

  Future<Usuario?> realizarLogin(String email, String senha) async {
    try {
      Usuario? usuario = await usuarioDAO.login(email, senha);

      DenunciaDAOImpl denunciaDAOImpl = DenunciaDAOImpl();

      return usuario;
    } catch (e) {
      //ignore: avoid_print
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
