# Organiza Leituras 📚

Aplicativo desenvolvido em Flutter como atividade da faculdade. O objetivo é organizar uma lista pessoal de livros e praticar navegação entre telas e armazenamento local de dados.

## Integrante

Luciara Pereira

## Funcionalidades

- Cadastrar livros informando título e autor.
- Selecionar o status da leitura: **Quero ler**, **Lendo** ou **Concluído**.
- Visualizar os livros cadastrados em uma lista.
- Remover livros da lista.
- Manter os dados salvos no dispositivo mesmo depois de fechar o aplicativo.

## Tecnologias utilizadas

- Flutter e Dart
- `Navigator` para navegação entre telas
- `StatefulWidget` e `setState` para atualização da interface
- `shared_preferences` para armazenamento local
- JSON para converter a lista de livros em texto e salvá-la no dispositivo

## Como executar

Com o Flutter instalado, abra o terminal na pasta do projeto e execute:

```bash
flutter pub get
flutter run
```

Depois, selecione o dispositivo ou emulador em que deseja abrir o aplicativo.

## Como usar

Na tela inicial, toque no botão **+** para cadastrar um livro. Preencha o título e o autor, escolha o status da leitura e toque em **Salvar livro**.

Para remover um livro, toque no ícone de lixeira ao lado dele.

