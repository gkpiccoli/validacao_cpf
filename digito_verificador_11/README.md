# Validação de CPF em Dart

## Visão Geral

Este repositório contém um programa em Dart para validar números de CPF brasileiros. O CPF (Cadastro de Pessoas Físicas) é o registro de identificação do contribuinte individual brasileiro. Este programa utiliza o algoritmo do módulo 11 para validar os números de CPF.

## Como Funciona

### Algoritmo do Módulo 11

O algoritmo do módulo 11 é utilizado para calcular os dois últimos dígitos do CPF, conhecidos como dígitos de verificação. O algoritmo multiplica cada dígito do CPF por um peso, soma esses produtos e, em seguida, calcula o módulo 11 dessa soma para obter os dígitos de verificação.

### Passos para Validação do CPF

1. Remova quaisquer caracteres não numéricos (como pontos e traços) do CPF inserido.
2. Verifique se o CPF tem exatamente 11 dígitos e se não consiste no mesmo dígito repetido 11 vezes.
3. Utilize o algoritmo do módulo 11 para calcular os dígitos de verificação a partir dos primeiros 9 dígitos do CPF.
4. Valide os dígitos de verificação calculados em relação aos dois últimos dígitos do CPF fornecido.

## Uso

Execute o programa e insira o número do CPF quando solicitado.

```dart
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
```

## Licença

Este projeto é de código aberto e está disponível sob a Licença MIT.

