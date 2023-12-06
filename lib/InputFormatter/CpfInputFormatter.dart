import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove caracteres não numéricos
    String cleanedCPF = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedCPF.length >= 4 && cleanedCPF.length < 7) {
      // Adiciona um ponto após o terceiro dígito
      return TextEditingValue(
        text: '${cleanedCPF.substring(0, 3)}.${cleanedCPF.substring(3)}',
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    } else if (cleanedCPF.length >= 7 && cleanedCPF.length < 10) {
      // Adiciona um ponto após o sexto dígito
      return TextEditingValue(
        text:
            '${cleanedCPF.substring(0, 3)}.${cleanedCPF.substring(3, 6)}.${cleanedCPF.substring(6)}',
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    } else if (cleanedCPF.length >= 10) {
      // Adiciona um traço após o nono dígito
      return TextEditingValue(
        text:
            '${cleanedCPF.substring(0, 3)}.${cleanedCPF.substring(3, 6)}.${cleanedCPF.substring(6, 9)}-${cleanedCPF.substring(9)}',
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    }

    // Mantém o valor como está
    return newValue;
  }
}
