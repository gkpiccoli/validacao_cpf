import 'dart:io';

bool isValidCPF(String cpf) {
  // Helper function to calculate individual verification digits
  int calcDigit(String slice, List<int> weights) {
    int sum = 0;
    for (int i = 0; i < slice.length; i++) {
      sum += int.parse(slice[i]) * weights[i];
    }
    final int mod = sum % 11;
    return (mod < 2) ? 0 : 11 - mod;
  }

  // Weights for the first and second verification digits
  final weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  final weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  // Slices of the CPF number for calculating the verification digits
  final slice1 = cpf.substring(0, 9);
  final slice2 = cpf.substring(0, 10);

  // Calculate the verification digits
  final digit1 = calcDigit(slice1, weights1);
  final digit2 = calcDigit(slice2, weights2);

  return '$digit1$digit2' == cpf.substring(9);
}

void main() {
  print('Por favor, digite o CPF para validação:');
  String? cpfInput = stdin.readLineSync();

  if (cpfInput == null) {
    print('Nenhum CPF foi digitado.');
    return;
  }

  // Check if input contains only numbers, dots, and dashes
  if (!RegExp(r'^[\d\.-]+$').hasMatch(cpfInput)) {
    print('O CPF deve conter apenas dígitos, pontos e traços.');
    return;
  }

  // Remove non-numeric characters
  String cleanedInput = cpfInput.replaceAll(RegExp(r'\D'), '');

  print('CPF após remoção de caracteres não numéricos: $cleanedInput');

  if (cleanedInput.length != 11) {
    print('O CPF deve ter exatamente 11 dígitos.');
  } else if (cleanedInput.split('').toSet().length == 1) {
    print('O CPF não pode ter todos os dígitos iguais.');
  } else {
    bool isValid = isValidCPF(cleanedInput);
    print(isValid ? 'O CPF é válido.' : 'O CPF é inválido.');
  }
}
