enum TipoAgendamento {
  Entulho,
  Reciclaveis,
  Eletronicos,
  Madeira,
  Pneus,
  Volumosos,
  PodasECapinas,
  outros;
}

extension TipoAgendamentoExtension on TipoAgendamento {
  // Método para resolver o problema de exibição do tipo de agendamento
  String toCustomString() {
    switch (this) {
      case TipoAgendamento.Entulho:
        return 'Descarte Irregular';
      case TipoAgendamento.Reciclaveis:
        return 'Recicláveis';
      case TipoAgendamento.Eletronicos:
        return 'Eletrônicos';
      case TipoAgendamento.Madeira:
        return 'Madeira';
      case TipoAgendamento.Pneus:
        return 'Pneus';
      case TipoAgendamento.Volumosos:
        return 'Volumosos';
      case TipoAgendamento.PodasECapinas:
        return 'Podas e Capinas';
      case TipoAgendamento.outros:
        return 'Outros';
      default:
        return this.toString().split('.').last;
    }
  }
}
