// Importing the dart:io library for standard input/output operations.
import 'dart:io';

/// Validates a Brazilian CPF number.
/// 
/// This function takes a CPF number as a string, validates it, and returns a boolean.
/// The CPF number can include dots and dashes as separators.
///
/// Example:
/// ```dart
/// print(isValidCPF('39053344705'));  // Returns true
/// print(isValidCPF('390.533.447-05'));  // Also returns true
/// ```
bool isValidCPF(String cpf) {
  // Remove any non-numeric characters like dots and dashes
  cpf = cpf.replaceAll(RegExp(r'\D'), '');

  // Check for correct length and not all equal digits
  // CPF must be 11 digits long and not have all digits the same
  if (cpf.length != 11 || RegExp(r'(\d)\1{10}').hasMatch(cpf)) {
    return false;
  }

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

  // Check if the calculated digits match the ones in the CPF number
  return '$digit1$digit2' == cpf.substring(9);
}

// Main function to get user input and validate the CPF number
void main() {
  print('Por favor, digite o CPF para validação:');
  String? cpfInput = stdin.readLineSync();

  if (cpfInput != null) {
    bool isValid = isValidCPF(cpfInput);
    if (isValid) {
      print('O CPF é válido.');
    } else {
      print('O CPF é inválido.');
    }
  } else {
    print('Nenhum CPF foi digitado.');
  }
}
