import 'package:projeto_coleta_seletiva/DAO/UsuarioDAOImpl.dart';
import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

class DeletarContaController {
  final UsuarioDAOImpl usuarioDAOImpl = UsuarioDAOImpl();

  Future<void> deletarConta(Usuario usuario) async {
    try {
      usuarioDAOImpl.remover(usuario);
    } catch (e) {
      return;
    }
  }

  Future<void> deletarContaeDados(Usuario usuario) async {
    try {
      usuarioDAOImpl.removerDadosDoUsuario(usuario);
      usuarioDAOImpl.remover(usuario);
    } catch (e) {
      return;
    }
  }
}
