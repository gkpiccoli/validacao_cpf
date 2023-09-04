# Validação de CPF em Dart

## Visão Geral

Este repositório contém um programa em Dart para validar números de CPF brasileiros. O CPF (Cadastro de Pessoas Físicas) é o registro de identificação do contribuinte individual brasileiro. O programa utiliza o algoritmo do módulo 11 para validar o CPF e também inclui verificações adicionais para tratar entradas inválidas.

## Como Funciona

### Algoritmo do Módulo 11

O algoritmo do módulo 11 é utilizado para calcular os dois últimos dígitos de verificação do CPF. O programa multiplica cada um dos primeiros 9 dígitos por um peso específico, soma esses produtos e calcula o módulo 11 dessa soma para determinar o primeiro dígito de verificação. O processo é então repetido, incluindo o primeiro dígito de verificação, para encontrar o segundo dígito de verificação.

### Passos para Validação do CPF

1. O programa pedirá que você digite o número do CPF para validação.
2. O programa verificará se a entrada contém apenas dígitos, pontos e traços.
3. O programa removerá caracteres não numéricos e exibirá o CPF "limpo" para confirmação.
4. Verifica se o CPF tem exatamente 11 dígitos e se não consiste no mesmo dígito repetido 11 vezes.
5. Utiliza o algoritmo do módulo 11 para calcular os dígitos de verificação.
6. Compara os dígitos de verificação calculados com os dois últimos dígitos do CPF fornecido.

## Uso

Para executar o programa, siga os seguintes passos:

1. Execute o programa Dart.
2. Insira o número do CPF quando solicitado.

O programa então realizará várias verificações e exibirá se o CPF é válido ou não.

```dart
void main() {
  print('Por favor, digite o CPF para validação:');
  // ... (o restante do código)
}
```

## Licença

Este projeto é de código aberto e está disponível sob a Licença MIT.

