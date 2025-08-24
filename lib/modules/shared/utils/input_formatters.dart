import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatters {
  static List<TextInputFormatter> get phoneNumberFormatter {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(15),
      MaskTextInputFormatter(mask: '(##) #####-####'),
    ];
  }

  static List<TextInputFormatter> get cpfFormatter {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(11),
      MaskTextInputFormatter(mask: '###.###.###-##'),
    ];
  }

  static List<TextInputFormatter> get cepFormatter {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(8),
      MaskTextInputFormatter(mask: '#####-###'),
    ];
  }
}
