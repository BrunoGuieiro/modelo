import 'package:modelo/modelo.dart' as modelo;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<List<dynamic>> buscarJogadorApi() async {
  final url = Uri.parse('https://www.thesportsdb.com/api/v1/json/3/searchplayers.php?p=cristiano');

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    Map<String, dynamic> corpoDecodificado = jsonDecode(resposta.body);

    return corpoDecodificado['player'];
  } else {
    throw Exception('Falha no servidor. Código: ${resposta.statusCode}');
  }
}

void main() async{
  List jogadores = await buscarJogadorApi();
  String jsonString = jsonEncode(jogadores);
  File arquivo = File('backup_api.json');
  arquivo.writeAsString(jsonString);
  print('Dados baixados e salvos com sucesso!');

   while (true) {
    print('1 - Listar todos os jogadores');
    print('2 - Pesquisar um jogador');
    print('3 - Remover um jogador');
    print('4 - Sair');

    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      String conteudo = await arquivo.readAsString();
      List dados = jsonDecode(conteudo);
      for (var jogador in dados) {
     print('Nome: ${jogador['strPlayer']}');
     print('Time: ${jogador['strTeam']}');
     print('Posição: ${jogador['strPosition']}');
     print('Nacionalidade: ${jogador['strNationality']}');
     print('-------------------------');
  }

    } else if (opcao == '2') {
    print('Digite o nome do jogador para pesquisar: ');
    String? busca = stdin.readLineSync();
    String conteudo = await arquivo.readAsString();
    List dados = jsonDecode(conteudo);

    for (var jogador in dados){
      if(jogador['strPlayer'] == busca){
      print('Nome: ${jogador['strPlayer']}');
      print('Time: ${jogador['strTeam']}');
      print('Posição: ${jogador['strPosition']}');
      print('Nacionalidade: ${jogador['strNationality']}');
      }
    }
    


    } else if (opcao == '3') {
      print('Digite o nome do jogador para excluir');
      String? excluir = stdin.readLineSync();
      String conteudo = await arquivo.readAsString();
      List dados = jsonDecode(conteudo);
   
      bool encontrou = false;

for (var jogador in dados) {
  if (jogador['strPlayer'] == excluir) {
    encontrou = true;
    break;
  }
}

if (encontrou) {
  dados.removeWhere((j) => j['strPlayer'] == excluir);
  await arquivo.writeAsString(jsonEncode(dados));
  print('Jogador removido com sucesso!');
} else {
  print('Nome de jogador não encontrado');
}

    } else if (opcao == '4') {
      break;

    } else {
      print('Opção errada');
    }
  }

}
