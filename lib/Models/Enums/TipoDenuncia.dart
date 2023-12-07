enum TipoDenuncia {
  DescarteIrregular,
  FaltaDeColeta,
  ObstrucaoDePatrimonio,
  outros;
}

extension TipoDenunciaExtension on TipoDenuncia {
  String toCustomString() {
    switch (this) {
      case TipoDenuncia.DescarteIrregular:
        return 'Descarte Irregular';
      case TipoDenuncia.FaltaDeColeta:
        return 'Falta de Coleta';
      case TipoDenuncia.ObstrucaoDePatrimonio:
        return 'Obstrução de Patrimônio';
      case TipoDenuncia.outros:
        return 'Outros';
      default:
        return this.toString().split('.').last;
    }
  }
}
