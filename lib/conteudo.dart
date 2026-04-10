abstract class Conteudo {
  int id;
  String titulo;
  int _classificacao = 0;
  List<double> _avaliacoes = [];

  Conteudo(this.id, this.titulo);

  int get classificacaoIndicativa => _classificacao;

  set validarClassificacao(int valor) {
    if (valor >= 0 && valor <= 18) {
      _classificacao = valor;
    } else {
      throw ArgumentError("Classificação inválida");
    }
  }

  void darPlay();
  void avaliar(double nota){
    if (nota >= 1.0 && nota <= 5.0) {
      _avaliacoes.add(nota);
    } else {
      throw Exception("Nota inválida! Use valores entre 1 e 5.");
    }
  }

   double get notaMedia {
    if (_avaliacoes.isEmpty) {
      return 0.0;
    }
    double soma = 0;
    for (var nota in _avaliacoes) {
      soma += nota;
    }
    return soma / _avaliacoes.length;
  }

  String get estrelas {
   return '⭐' * notaMedia.round();
  }


  Map<String, dynamic> toJson();
}

class Filme extends Conteudo {
 Filme(int id, String titulo) : super(id, titulo);

  @override
 void darPlay() {
   print('Reproduzindo o filme: $titulo');
 }

 @override
 Map<String, dynamic> toJson(){
  return {'id': id, 'titulo': titulo, 'classificacao': _classificacao, 'avaliacoes': _avaliacoes};
 }
}

class Serie extends Conteudo {
 int temporadas;
 Serie(int id, String titulo, this.temporadas) : super(id, titulo);



  @override
 void darPlay() {
   print('Iniciando a serie $titulo com $temporadas temporadas');
 }

 @override
 Map<String, dynamic> toJson(){
  return {'id': id, 'titulo': titulo, 'classificacao': _classificacao, 'temporadas': temporadas, 'avaliacoes': _avaliacoes};
 }
}