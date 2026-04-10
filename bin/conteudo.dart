import 'dart:io';
import 'dart:convert';
import 'package:conteudo/conteudo.dart';

void salvarCatalogo(List<Conteudo> catalogo) {
  final arquivo = File('./dados.json');

  arquivo.writeAsStringSync(
      jsonEncode(catalogo.map((item) => item.toJson()).toList()));
}

void main() {
  final arquivo = File('./dados.json');
  String conteudo = arquivo.readAsStringSync();

  List<dynamic> dados = jsonDecode(conteudo);

  List<Conteudo> catalogo = [];

  for (var item in dados) {
    try {
      Filme filme = Filme(item['id'], item['titulo']);
      filme.validarClassificacao = item['classificacao'];

      List<double> avaliacoes = List<double>.from(item['avaliacoes']);
      for (var nota in avaliacoes) {
        filme.avaliar(nota);
      }

      catalogo.add(filme);
      print("Filme '${filme.titulo}' adicionado ao catálogo!");
    } catch (e) {
      print(e);
    }
  }

  int opcao = 0;

  while (opcao != 4) {
    print("\nCatálogo:");
    for (var item in catalogo) {
     print("ID: ${item.id} | ${item.titulo} | Avaliação: ${item.estrelas} (${item.notaMedia})");
    }
    print("------------------------------------");
    print("[1] Cadastrar Filme | [2] Deletar | [3] Avaliar | [4] Sair ");
    opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        print("Digite o ID:");
        int id = int.parse(stdin.readLineSync()!);

        print("Digite o título:");
        String titulo = stdin.readLineSync()!;

        print("Digite a classificação:");
        int classificacao = int.parse(stdin.readLineSync()!);

        try {
          bool idExiste = catalogo.any((item) => item.id == id);

          if (idExiste) {
            throw Exception("Erro: ID já cadastrado no sistema!");
          }
          Filme filme = Filme(id, titulo);
          filme.validarClassificacao = classificacao;
          catalogo.add(filme);
        } catch (e) {
          print(e);
        }
        break;

      case 2:
        print("Selecione um ID para exclusão:");
        int idExclusao = int.parse(stdin.readLineSync()!);

        catalogo.removeWhere((Atual) => Atual.id == idExclusao);
        break;

      case 3:
        print("Digite o ID do conteúdo:");
        int idBusca = int.parse(stdin.readLineSync()!);

        print("Digite a nota (1 a 5):");
        double nota = double.parse(stdin.readLineSync()!);

        try {
          Conteudo? encontrado;

          for (var item in catalogo) {
            if (item.id == idBusca) {
              encontrado = item;
              break;
            }
          }

          if (encontrado == null) {
            print("Conteúdo não encontrado!");
          } else {
            encontrado.avaliar(nota);
            print("Avaliação adicionada com sucesso!");
          }
        } catch (e) {
          print(e);
        }
        break;
      case 4:
        break;

      default:
        print("Opção inválida!");
    }

    salvarCatalogo(catalogo);
  }
}
