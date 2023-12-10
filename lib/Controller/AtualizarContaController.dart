import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class AtualizarContaController {
  final UsuarioDAOImpl usuarioDAOImpl = UsuarioDAOImpl();

  Future<void> at(Usuario usuario) async {
    try {
      usuarioDAOImpl.atualizarCadastro(usuario);
    } catch (e) {
      return;
    }
  }
}
