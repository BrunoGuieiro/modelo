class Jogador {
  int id;
  String nome;
  String time;
  String posicao;
  String nacionalidade;

  Jogador({
    required this.id,
    required this.nome,
    required this.time,
    required this.posicao,
    required this.nacionalidade,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'time': time,
      'posicao': posicao,
      'nacionalidade': nacionalidade,
    };
  }
}