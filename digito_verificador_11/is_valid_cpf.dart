//TODO: implantar 00000000 11111111 222222 33333...
// Importando Dart I/O para stdin e stdout
import 'dart:io';

// Função para validar um CPF brasileiro
bool isValidCPF(String cpf) {
  // Função auxiliar para calcular o dígito verificador
  int calcDigit(String slice, List<int> weights) {
    // Calcular a soma dos dígitos ponderados
    final sum = slice
        .split('')
        .asMap()
        .map((i, digit) => MapEntry(i, int.parse(digit) * weights[i]))
        .values
        .reduce((a, b) => a + b);

    // Calcular o módulo e o dígito verificador
    final int mod = sum % 11;
    return (mod < 2) ? 0 : 11 - mod;
  }

  // Pesos para os primeiros e segundos dígitos de verificação
  final weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  final weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  // Partes do CPF para calcular os dígitos de verificação
  final slice1 = cpf.substring(0, 9);
  final slice2 = cpf.substring(0, 10);

  // Calcular os dígitos de verificação
  final digit1 = calcDigit(slice1, weights1);
  final digit2 = calcDigit(slice2, weights2);

  // Validar o CPF
  return '$digit1$digit2' == cpf.substring(9);
}

// Função para limpar e validar a entrada do CPF
String? cleanAndValidateInput(String? cpfInput) {
  if (cpfInput == null || cpfInput.trim().isEmpty) {
    return null;
  }
  if (!RegExp(r'^[\d\.-]+$').hasMatch(cpfInput)) {
    return null;
  }
  return cpfInput.replaceAll(RegExp(r'\D'), '');
}

// Função para validar o CPF limpo
bool validateCleanedCPF(String cleanedInput) {
  if (cleanedInput.length != 11 || cleanedInput.split('').toSet().length == 1) {
    return false;
  }
  return true;
}

void main() {
  print('Por favor, digite o CPF para validação:');
  String? cpfInput = stdin.readLineSync();

  String? cleanedInput = cleanAndValidateInput(cpfInput);

  if (cleanedInput == null) {
    print('Erro: Entrada inválida. Tente novamente.');
    return;
  }

  if (!validateCleanedCPF(cleanedInput)) {
    print('Erro: CPF inválido. Tente novamente.');
    return;
  }

  bool isValid = isValidCPF(cleanedInput);
  print('CPF digitado: $cpfInput');
  print('CPF limpo: $cleanedInput');
  // Supondo que a função isValidCPF esteja definida em outro lugar
  print(isValid
      ? 'Sucesso: O CPF é válido.'
      : 'Erro: O CPF é inválido. Tente novamente.');
}
