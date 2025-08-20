import 'package:brasil_fields/brasil_fields.dart';

class InputValidators {
  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    if (value.length < 3) {
      return 'Nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório';
    }
    final mobileRegex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Telefone inválido';
    }
    return null;
  }

  static String? validateRg(String? value) {
    if (value == null || value.isEmpty) {
      return 'RG é obrigatório';
    }

    return null;
  }

  static String? validateCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedValue.length != 11 || !CPFValidator.isValid(cleanedValue)) {
      return 'CPF inválido';
    }
    return null;
  }

  static String? validateCep(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP é obrigatório';
    }
    final cepRegex = RegExp(r'^\d{5}-\d{3}$');
    if (!cepRegex.hasMatch(value)) {
      return 'CEP inválido';
    }
    return null;
  }
}
