
// Importing necessary Dart libraries
import 'dart:io';

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
  // Your CPF validation logic here
  // ...
  return true;  // Placeholder
}

// Function to validate CNPJ
bool isValidCNPJ(String cnpj) {
  // Your CNPJ validation logic here
  // ...
  return true;  // Placeholder
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

// Main function for testing
void main() {
  print("Enter a CPF or CNPJ:");
  String input = stdin.readLineSync()!;
  
  isValidCPForCNPJ(input);
}