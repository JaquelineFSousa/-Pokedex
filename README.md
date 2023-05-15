# Pokedex - Flutter

Projeto Flutter

## Documentação: 

Este documento descreve a implementação de uma Pokedex utilizando o framework Flutter.

 A Pokedex consiste em três telas:
- Login 
- Grid com 8 pokemons
- Tela de informações

Os conceitos básicos do Flutter são aplicados, incluindo a estrutura do projeto, uso de dados entre telas e implementação das telas.


- Estrutura do Projeto:

- O projeto possui a seguinte estrutura:

pokedex/
  - lib/
       - main.dart
       - paginas/
            - home_page.dart
            - pokemon_list.dart
            - pokemon_info.dart

   - lib/main.dart: Ponto de entrada do aplicativo Flutter.
   - lib/paginas/home_page.dart: Tela de login.
   - lib/paginas/pokemon_list.dart: Tela com uma grade de 8 pokémons.
   - lib/paginas/pokemon_info.dart: Tela com informações detalhadas do pokemon selecionado.

- Implementação:

    Criação de uma tela de login, que é apenas visual.
    Criação da tela de grid, exibindo 8 pokemons clicáveis.
    Implementação da tela de informações, mostrando os detalhes do pokemon selecionado.
    Uso do Navigator para navegação entre as telas.
    Passagem de dados entre as telas, compartilhando o objeto pokemon selecionado.

- Uso de Dados entre Telas:

Para compartilhar os dados do pokemon selecionado entre as telas, utilize o Navigator.
Ao clicar em um pokemon na tela de grid, navegue para a tela de informações e passe o objeto Pokemon correspondente.
Na tela de informações, recupere o objeto Pokemon recebido e utilize-o para exibir as informações.



                              ![imagem da home](assets/images/pokemon.png)
