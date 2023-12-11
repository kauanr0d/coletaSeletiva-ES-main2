import 'package:projeto_coleta_seletiva/Models/Usuario.dart';

abstract class UsuarioDAO {
  salvarUsuario(Usuario usuario);
  remover(Usuario usuario);
  Future<List<Usuario>> buscarUsuario(Usuario usuario);
  Future<bool> verificarUsuarioExistente(String email);
  Future<void> resetSenha(String email, String novaSenha);
}
