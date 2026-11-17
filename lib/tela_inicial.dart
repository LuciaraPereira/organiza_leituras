import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'livro.dart';
import 'tela_cadastro.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final SharedPreferencesAsync preferencias = SharedPreferencesAsync();

  List<Livro> livros = [];

  bool carregando = true;
  bool salvando = false;
  bool erroCarregamento = false;

  @override
  void initState() {
    super.initState();
    carregarLivros();
  }

  Future<void> carregarLivros() async {
    setState(() {
      carregando = true;
      erroCarregamento = false;
    });

    try {
      final dados = await preferencias.getString('livros');

      final List<dynamic> lista = dados == null
          ? []
          : jsonDecode(dados) as List<dynamic>;

      final livrosRecuperados = lista.map((item) {
        return Livro.deMapa(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        livros = livrosRecuperados;
        carregando = false;
      });
    } catch (erro) {
      if (!mounted) return;

      setState(() {
        carregando = false;
        erroCarregamento = true;
      });
    }
  }

  Future<void> salvarLista(
    List<Livro> novaLista,
    String mensagem,
  ) async {
    setState(() {
      salvando = true;
    });

    try {
      // A lista de livros é convertida em JSON para ser salva
      // como um texto no armazenamento de chave e valor.
      final dados = jsonEncode(
        novaLista.map((livro) => livro.paraMapa()).toList(),
      );

      await preferencias.setString('livros', dados);

      if (!mounted) return;

      setState(() {
        livros = novaLista;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível salvar os livros. Tente novamente.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  Future<void> abrirCadastro() async {
    final livro = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaCadastro(),
      ),
    );

    if (!mounted || livro == null) return;

    await salvarLista(
      [...livros, livro],
      'Livro cadastrado com sucesso!',
    );
  }

  void removerLivro(int indice) {
    final novaLista = List<Livro>.from(livros);
    novaLista.removeAt(indice);

    salvarLista(
      novaLista,
      'Livro removido com sucesso!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas leituras • Luciara Pereira'),
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : erroCarregamento
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Não foi possível carregar os livros.'),
                      TextButton(
                        onPressed: carregarLivros,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                )
              : livros.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum livro cadastrado.\n'
                        'Toque em + para adicionar.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: livros.length,
                      itemBuilder: (context, indice) {
                        final livro = livros[indice];

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.menu_book),
                            title: Text(livro.titulo),
                            subtitle: Text(
                              '${livro.autor}\n${livro.status}',
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              tooltip: 'Remover livro',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: salvando
                                  ? null
                                  : () {
                                      removerLivro(indice);
                                    },
                            ),
                          ),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: carregando || erroCarregamento || salvando
            ? null
            : abrirCadastro,
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}