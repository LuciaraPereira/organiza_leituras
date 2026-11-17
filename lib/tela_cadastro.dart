import 'package:flutter/material.dart';
import 'livro.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();

  String status = 'Quero ler';

  @override
  void dispose() {
    tituloController.dispose();
    autorController.dispose();
    super.dispose();
  }

  void cadastrarLivro() {
    final titulo = tituloController.text.trim();
    final autor = autorController.text.trim();

    if (titulo.isEmpty || autor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe o título e o autor.'),
        ),
      );
      return;
    }

    final livro = Livro(
      titulo: titulo,
      autor: autor,
      status: status,
    );

    Navigator.pop(context, livro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar livro • Luciara Pereira'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Status da leitura'),
            DropdownButton<String>(
              value: status,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Quero ler',
                  child: Text('Quero ler'),
                ),
                DropdownMenuItem(
                  value: 'Lendo',
                  child: Text('Lendo'),
                ),
                DropdownMenuItem(
                  value: 'Concluído',
                  child: Text('Concluído'),
                ),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    status = valor;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: cadastrarLivro,
              icon: const Icon(Icons.save),
              label: const Text('Salvar livro'),
            ),
          ],
        ),
      ),
    );
  }
}