class Livro {
  final String titulo;
  final String autor;
  final String status;

  Livro({
    required this.titulo,
    required this.autor,
    required this.status,
  });

  Map<String, String> paraMapa() {
    return {
      'titulo': titulo,
      'autor': autor,
      'status': status,
    };
  }

  factory Livro.deMapa(Map<String, dynamic> mapa) {
    return Livro(
      titulo: mapa['titulo'] as String,
      autor: mapa['autor'] as String,
      status: mapa['status'] as String,
    );
  }
}