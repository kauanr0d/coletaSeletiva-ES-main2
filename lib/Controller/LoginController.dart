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
      Denuncia denuncia = Denuncia(
        TipoDenuncia.DescarteIrregular,
        "Aqui na rua",
        null,
        DateTime.now(),
        bairro: "Nome do Bairro555",
        cep: "12345-678",
        rua: "Nome da Rua123",
        numero: "12345",
      );
      DenunciaDAOImpl denunciaDAOImpl = DenunciaDAOImpl();
      denunciaDAOImpl.salvarDenuncia(denuncia, usuario!);

      return usuario;
    } catch (e) {
      //ignore: avoid_print
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
