# CoinAPI

![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg)
![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

> Projeto em Swift que lista exchanges e exibe detalhes de cada exchange utilizando a CoinAPI.

## Descrição

O CoinAPI Project é um aplicativo iOS que permite aos usuários visualizar uma lista de exchanges e obter informações detalhadas sobre cada uma delas. O projeto utiliza a API CoinAPI para obter os dados das exchanges e segue a arquitetura MVVM-C (Model-View-ViewModel-Coordinator), juntamente com os padrões de design Builder, Adapter e Coordinator.

## Características

- Lista de exchanges: exibe uma lista de exchanges disponíveis.
- Detalhes da exchange: mostra informações detalhadas sobre uma exchange selecionada.
- Integração com a CoinAPI: utiliza a CoinAPI para obter os dados das exchanges.
- Arquitetura MVVM-C: utiliza a arquitetura Model-View-ViewModel-Coordinator para separar as responsabilidades e facilitar a manutenção do código.
- Design Patterns: utiliza os padrões de design Builder, Adapter e Coordinator para melhorar a estrutura e a reutilização do código.

## Requisitos

- Xcode 12 ou superior
- Swift 5.0 ou superior
- Cocoapods (para instalação de dependências)

## Instalação

1. Clone o repositório para o seu ambiente de desenvolvimento local:
git clone [https://github.com/lucas-pedroso-developer/CoinAPI.git]

2. Navegue até o diretório do projeto:
cd CoinAPI

3. Instale as dependências usando o Cocoapods:
pod install

4. Abra o arquivo `CoinAPI.xcworkspace` no Xcode:
open coinapi-project.xcworkspace


5. Compile e execute o projeto no simulador ou dispositivo iOS de sua escolha.

## Estrutura do Projeto


- `Utilities`: contém utilitários e classes auxiliares utilizados em todo o projeto.
- `Data`: contém os repositórios responsáveis por acessar e persistir os dados.
- `Domain`: contém os modelos de dados (entidades) e os casos de uso (UseCases) do domínio do aplicativo.
- `Network`: contém os componentes e serviços de integração com a CoinAPI.
- `Presentation`: contém as classes de view model, view controllers e views responsáveis por exibir e gerenciar a interface do usuário.
- `Tests`: contém os testes unitários e de snapshot do projeto.


## Contribuindo

Contribuições são bem-vindas! Se você tiver sugestões, correções de bugs ou melhorias para o projeto, fique à vontade para abrir uma issue ou enviar um pull request.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para obter mais informações.
