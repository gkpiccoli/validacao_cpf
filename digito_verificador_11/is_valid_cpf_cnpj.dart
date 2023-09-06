// Importing necessary Dart libraries
import 'dart:io';

void main() {
  String input;

  const String green = '\x1B[32m';
  const String yellow = '\x1B[33m';
  const String red = '\x1B[31m';
  const String cyan = '\x1B[36m';
  const String reset = '\x1B[0m';

  while (true) {
    // Enter loop
    print("$green\n==========================================================");
    print("               🛡️  Validador de Dígitos  🛡️               ");
    print("==========================================================$reset\n");

    print("$cyan🔍 Este programa verifica a validade de CPFs e CNPJs.\n");
    print(
        "$yellow👉 Por favor, digite um CPF ou CNPJ (ou 'sair' para terminar): $reset");
    input = stdin.readLineSync()!;

    if (input.toLowerCase() == 'sair') {
      print(
          "\n$red👋 Obrigado por usar o Validador de Dígitos. Até mais! 👋$reset\n");
      break; // Exit loop
    }

    bool isValid = isValidCPForCNPJ(input);

    if (isValid) {
      print("$green✅ Válido!$reset");
    } else {
      print("$red❌ Inválido!$reset");
    }
  }
}

// Function to apply mask to CPF
String applyMaskToCPF(String cpf) {
  return cpf.substring(0, 3) +
      '.' +
      cpf.substring(3, 6) +
      '.' +
      cpf.substring(6, 9) +
      '-' +
      cpf.substring(9);
}

// Function to apply mask to CNPJ
String applyMaskToCNPJ(String cnpj) {
  return cnpj.substring(0, 2) +
      '.' +
      cnpj.substring(2, 5) +
      '.' +
      cnpj.substring(5, 8) +
      '/' +
      cnpj.substring(8, 12) +
      '-' +
      cnpj.substring(12);
}

// Function to validate CPF
bool isValidCPF(String cpf) {
  int calcDigit(String slice, List<int> weights) {
    // Calculate the sum of the weighted digits
    final sum = slice
        .split('')
        .asMap()
        .map((i, digit) => MapEntry(i, int.parse(digit) * weights[i]))
        .values
        .reduce((a, b) => a + b);

    // Calculate the remainder of the sum when divided by 11
    final int mod = sum % 11;
    return (mod < 2) ? 0 : 11 - mod;
  }

  // Weights for the first and second verification digits of CPF
  final List<int> weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  final List<int> weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  // Slices of ther CPF to calculate the verification digits

  final String slice1 = cpf.substring(0, 9);
  final String slice2 = cpf.substring(0, 10);

  // Calculate the verification digits
  final int digit1 = calcDigit(slice1, weights1);
  final int digit2 = calcDigit(slice2, weights2);

  // Validate the CPF
  return '$digit1$digit2' == cpf.substring(9);
}

// Function to validate CNPJ
bool isValidCNPJ(String cnpj) {
  // Function to calculate the verification digit
  int calcDigit(String slice, List<int> weights) {
    // Calculate the sum of the weighted digits
    int sum = 0;
    for (int i = 0; i < slice.length; i++) {
      sum += int.parse(slice[i]) * weights[i];
    }

    // Calculate the remainder of the sum when divided by 11
    int remainder = sum % 11;

    // If the remainder is less than 2, the verification digit is 0.
    // Otherwise, it is 11 minus the remainder.
    return remainder < 2 ? 0 : 11 - remainder;
  }

  // Weights for the first and second verification digits of CNPJ
  final List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  final List<int> weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  // Slices of the CNPJ to calculate the verification digits
  final String slice1 = cnpj.substring(0, 12);
  final String slice2 = cnpj.substring(0, 13);

  // Calculate the verification digits
  final int digit1 = calcDigit(slice1, weights1);
  final int digit2 = calcDigit(slice2, weights2);

  // Validate the CNPJ
  return '$digit1$digit2' == cnpj.substring(12);
}

// Function to identify and validate CPF or CNPJ
bool isValidCPForCNPJ(String input) {
  input = input.replaceAll(RegExp(r'[^0-9]'), '');

  // Check if the input is a CPF
  if (input.length == 11 && isValidCPF(input)) {
    print("O CPF é válido: " + applyMaskToCPF(input));
    return true;
  }

  // Check if the input is a CNPJ
  if (input.length == 14 && isValidCNPJ(input)) {
    print("O CNPJ é válido: " + applyMaskToCNPJ(input));
    return true;
  }

  print("Entrada inválida. Digite um número de CPF ou CNPJ válido.");
  return false;
}
