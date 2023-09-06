
// Importing necessary Dart libraries
import 'dart:io';

// Main function for testing
void main() {
  print("Enter a CPF or CNPJ:");
  String input = stdin.readLineSync()!;
  
  isValidCPForCNPJ(input);
}

// Function to apply mask to CPF
String applyMaskToCPF(String cpf) {
  return cpf.substring(0, 3) + '.' + cpf.substring(3, 6) + '.' + cpf.substring(6, 9) + '-' + cpf.substring(9);
}

// Function to apply mask to CNPJ
String applyMaskToCNPJ(String cnpj) {
  return cnpj.substring(0, 2) + '.' + cnpj.substring(2, 5) + '.' + cnpj.substring(5, 8) + '/' + cnpj.substring(8, 12) + '-' + cnpj.substring(12);
}

// Function to validate CPF
bool isValidCPF(String cpf) {
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
  final List<int>weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  final List<int>weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  // Partes do CPF para calcular os dígitos de verificação
  final String slice1 = cpf.substring(0, 9);
  final String slice2 = cpf.substring(0, 10);

  // Calcular os dígitos de verificação
  final int digit1 = calcDigit(slice1, weights1);
  final int  digit2 = calcDigit(slice2, weights2);

  // Validar o CPF
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
    print("CPF is valid: " + applyMaskToCPF(input));
    return true;
  }
  
  // Check if the input is a CNPJ
  if (input.length == 14 && isValidCNPJ(input)) {
    print("CNPJ is valid: " + applyMaskToCNPJ(input));
    return true;
  }

  print("Invalid input. Neither a valid CPF nor a valid CNPJ.");
  return false;
}

